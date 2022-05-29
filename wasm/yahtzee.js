const fs = require('fs');
const bytes = fs.readFileSync(__dirname + '/yahtzee.wasm');

const n = 10000000;
const importedObject = {
  js: {
    random: Math.random,
    n,
  }
};

(async () => {
  const obj = await WebAssembly.instantiate(new Uint8Array(bytes), importedObject);
  const { runSimulation } = obj.instance.exports;
  console.log(runSimulation());
})();