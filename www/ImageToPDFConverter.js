var exec = require('cordova/exec');

exports.coolMethod = function (arg0, success, error) {
    exec(success, error, 'ImageToPDFConverter', 'coolMethod', [arg0]);
};

exports.createPdf = function (arg0, success, error) {
    exec(success, error, 'ImageToPDFConverter', 'createPdf', [arg0]);
};
