var exec = require('cordova/exec');

exports.createPdf = function (arg0, arg1, arg2 = '', arg3 = '', success, error) {
    exec(success, error, 'ImageToPDFConverter', 'createPdf', [arg0, arg1, arg2, arg3]);
};
