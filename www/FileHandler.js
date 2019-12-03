var FileExport = {};

FileExport.callFunction = function(
  successCallback,
  errorCallback,
  action,
  param
) {
  cordova.exec(successCallback, errorCallback, "FileHandler", action, param);
};

module.exports = FileExport;
