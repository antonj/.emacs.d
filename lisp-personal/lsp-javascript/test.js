const A = "hej";
const B = 1;

A + B;

/** @type {function(number): function(number): number} */
const adder = a => b => a + b;
const add2 = adder(2);
const add4 = adder(4);
add4.call(4);

var b = {
  a: 1,
  c: {
    birds: [{ name: "hej" }]
  }
};

const four = add2(2);
const x = four + adder(b.a)(3)
