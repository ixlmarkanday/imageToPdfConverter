var exec = require('cordova/exec');

exports.createPdf = function (arg0, success, error) {
    exec(success, error, 'ImageToPDFConverter', 'createPdf', [arg0]);
};
