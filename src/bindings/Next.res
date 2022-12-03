module Req = {
  type t

  @get
  external cookies: t => Js.Dict.t<string> = "cookies"

  @get external method: t => string = "method"
  @get external url: t => string = "url"
  @get external port: t => int = "port"
  @get external headers: t => Js.Dict.t<string> = "headers"
  @get
  external rawHeaders: t => array<string> = "rawHeaders"
  @get
  external rawTrailers: t => array<string> = "rawTrailers"
  @get external aborted: t => bool = "aborted"
  @get external complete: t => bool = "complete"
  @send external destroy: t => unit = "destroy"
  @send
  external destroyWithError: (t, Js.Exn.t) => bool = "destroy"
  @get external statusCode: t => int = "statusCode"
  @get
  external statusMessage: t => string = "statusMessage"
  @get
  external trailers: t => Js.Dict.t<string> = "trailers"
}

module Res = {
  type t

  @get external statusCode: t => int = "statusCode"
  @get external statusMessage: t => string = "statusMessage"
  @set
  external setStatusCode: (t, int) => unit = "statusCode"
  @send
  external getHeader: (t, string) => option<string> = "getHeader"
  @send
  external setHeader: (t, string, string) => unit = "setHeader"
  @send external end: (t, 'a) => unit = "end"
}

module GetServerSideProps = {
  type result =
    | Props({.})
    | NotFound
    | Redirect(string)
    | RedirectPermanent(string)
    | RedirectStatusCode(string, int)

  type context<'params> = {
    req: Req.t,
    res: Res.t,
    params: 'params,
    query: Js.Dict.t<string>,
    resolvedUrl: string,
    locale: string,
    locales: array<string>,
    defaultLocale: string,
  }

  type t<'a, 'b> = context<'b> => Js.Promise.t<result>

  let parseResult = result =>
    switch result {
    | Props(result) => {"props": result}->Obj.magic
    | NotFound => {"notFound": true}->Obj.magic
    | Redirect(url) => {"redirect": {"destination": url, "permanent": false}}->Obj.magic
    | RedirectPermanent(url) => {"redirect": {"destination": url, "permanent": true}}->Obj.magic
    | RedirectStatusCode(url, statusCode) =>
      {
        "redirect": {"destination": url, "statusCode": statusCode},
      }->Obj.magic
    }

  let make = (callback: t<'a, 'b>, context: context<'b>) => {
    callback(context) |> Js.Promise.then_(result => result->parseResult->Js.Promise.resolve)
  }
}

module Link = {
  @module("next/link") @react.component
  external make: (
    ~href: string,
    @as("as") ~_as: string=?,
    ~prefetch: bool=?,
    ~scroll: bool=?,
    ~replace: option<bool>=?,
    ~shallow: option<bool>=?,
    ~passHref: option<bool>=?,
    ~children: React.element,
    ~locale: string=?,
    ~ref: ReactDOM.domRef=?,
  ) => React.element = "default"
}

module Router = {
  module Events = {
    type t

    @send
    external on: (
      t,
      @string
      [
        | #routeChangeStart(string => unit)
        | #routeChangeComplete(string => unit)
        | #hashChangeComplete(string => unit)
      ],
    ) => unit = "on"

    @send
    external off: (
      t,
      @string
      [
        | #routeChangeStart(string => unit)
        | #routeChangeComplete(string => unit)
        | #hashChangeComplete(string => unit)
      ],
    ) => unit = "off"
  }

  type router = {
    route: string,
    asPath: string,
    events: Events.t,
    pathname: string,
    query: Js.Dict.t<string>,
  }

  type pathObj = {
    pathname: string,
    query: Js.Dict.t<string>,
  }

  @deriving(abstract)
  type options = {
    @optional
    scroll: bool,
    @optional
    prefetch: bool,
    @optional
    shallow: bool,
  }

  type state = {
    url: string,
    @as("as") _as: string,
    options: options,
  }

  @send external push: (router, string) => unit = "push"
  @send external pushObj: (router, pathObj) => unit = "push"
  @send external pushWithAs: (router, string, option<string>, ~options: options=?) => unit = "push"

  @module("next/router") external useRouter: unit => router = "useRouter"

  @send external replace: (router, string) => unit = "replace"
  @send external replaceObj: (router, pathObj) => unit = "replace"
  @send
  external replaceWithAs: (router, string, option<string>, ~options: options=?) => unit = "replace"

  @scope("options") @set external setScrollOption: (state, bool) => unit = "scroll"

  @send
  external beforePopState: (router, state => bool) => unit = "beforePopState"

  @send
  external clearBeforePopState: router => unit = "beforePopState"
}
