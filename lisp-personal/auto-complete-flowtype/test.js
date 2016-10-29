// @flow

//(setq ac-sources '(ac-source-flowtype))

type ObjectWithManyProperties = {
  foo: string,
  bar: number,
  baz: boolean,
  qux: (foo: string, bar: number) => boolean;
}

function foo(x) {
  return x * 10
}

function anton(o: ObjectWithManyProperties, s: string, n: number) {
  let b = {
    x: 2,
    d: 1
  }
}
