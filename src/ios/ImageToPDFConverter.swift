@objc(ImageToPDFConverter) class ImageToPDFConverter : CDVPlugin {
  @objc(coolMethod:)
  func coolMethod(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let msg = command.arguments[0] as? String ?? ""

    if msg.characters.count > 0 {
      let toastController: UIAlertController =
        UIAlertController(
          title: "",
          message: msg,
          preferredStyle: .alert
        )

      self.viewController?.present(
        toastController,
        animated: true,
        completion: nil
      )

      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        toastController.dismiss(
          animated: true,
          completion: nil
        )
      }

      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: msg
      )
    }

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  @objc(createPdf:)  func createPdf(_ command: CDVInvokedUrlCommand) {
     var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

     let imagesPath = command.arguments[0] as? String ?? ""
     var imageArrayOfPath : [UIImage]?
     for index in 0..<(imagesPath?.count ?? 0){
         let url = URL.init(fileURLWithPath: imagesPath![index])
         let imageData:NSData = NSData(contentsOf: url)!
         let image = UIImage(data: imageData as Data)
         imageArrayOfPath?.append(image!)
     }

     let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
     let fileURL:URL = documentsURL
     do {
         try FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: true, attributes: nil)
     } catch let error as NSError {
         NSLog("Unable to create directory \(error.debugDescription)")
     }
     UIGraphicsBeginPDFContextToFile(fileURL.appendingPathComponent("note.pdf").path, CGRect.zero, nil);
     for index in 0..<(imageArrayOfPath?.count ?? 0) {
         let pngImage = imageArrayOfPath?[index]
         UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: (pngImage?.size.width) ?? 0.0, height: (pngImage?.size.height) ?? 0.0), nil)
         pngImage?.draw(in: CGRect(x: 0, y: 0, width: (pngImage?.size.width) ?? 0.0, height: (pngImage?.size.height) ?? 0.0))
     }
     UIGraphicsEndPDFContext()

     pluginResult = CDVPluginResult(
         status: CDVCommandStatus_OK,
         messageAs: 'pdf created successfully',
         path: fileURL.path
     )

     self.commandDelegate!.send(
        pluginResult,
        callbackId: command.callbackId
     )
  }
}
