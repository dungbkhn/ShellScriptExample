var fs = require('fs'); 

var d = Date.now()


let data = d+"\n";
  console.log(data);
// Write data in 'read_file.txt
fs.appendFile('./temp/userlogged.checkfile', data, (err) => {
      
    // In case of a error throw err.
    if (err) throw err;
})
