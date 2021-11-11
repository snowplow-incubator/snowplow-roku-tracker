const path = require('path');
const ProgramBuilder = require('brighterscript').ProgramBuilder;

let programBuilder = new ProgramBuilder();
programBuilder.run({
  project: path.join(__dirname, '../', 'bsconfig-tests.json')
}).catch(e => {
  console.error(e);
});
