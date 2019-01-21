@objc(ImageToPDFConverter) class ImageToPDFConverter : CDVPlugin {
    @objc(createPdf:)
    func createPdf(_ command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

        var imagesPath = command.arguments[0] as? [String]
        var pdfFileName = command.arguments[1] as? String
        print("###\((imagesPath)!)")
       //var imageArrayOfPath : [UIImage]?
       //if(imagesPath?.count == 0){
       //    pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "image path field is required as array datatype.")
       //    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
       //    return
       //}
       //for index in 0..<(imagesPath?.count ?? 0){
       //    let url = URL.init(fileURLWithPath: imagesPath![index])
       //    let imageData:NSData = NSData(contentsOf: url)!
       //    let image = UIImage(data: imageData as Data)
       //    imageArrayOfPath?.append(image!)
       //}

       //let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
       //let fileURL:URL = documentsURL
       //do {
       //try FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: true, attributes: nil)
       //} catch let error as NSError {
       //NSLog("Unable to create directory \(error.debugDescription)")
       //}
       //UIGraphicsBeginPDFContextToFile(fileURL.appendingPathComponent(pdfFileName!).path, CGRect.zero, nil);
       //for index in 0..<(imageArrayOfPath?.count ?? 0) {
       //    let pngImage = imageArrayOfPath?[index]
       //    UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: (pngImage?.size.width) ?? 0.0, height: (pngImage?.size.height) ?? 0.0), nil)
       //    pngImage?.draw(in: CGRect(x: 0, y: 0, width: (pngImage?.size.width) ?? 0.0, height: (pngImage?.size.height) ?? 0.0))
       //}
       //UIGraphicsEndPDFContext()

        var imageArray = [UIImage]()

        for imagesPath in imagesPath!{
            let documentDirectoryPath = imagesPath
            let image    = UIImage(contentsOfFile: documentDirectoryPath)
            imageArray.append(image!)
        }
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL:URL = documentsURL
        do {
            try FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
        UIGraphicsBeginPDFContextToFile(fileURL.appendingPathComponent(pdfFileName!).path, CGRect.zero, nil);
        for index in 0..<(imageArray.count ) {
            let pngImage = imageArray[index]
            UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: (pngImage.size.width) , height: (pngImage.size.height) ), nil)
            pngImage.draw(in: CGRect(x: 0, y: 0, width: (pngImage.size.width) , height: (pngImage.size.height) ))
        }
        UIGraphicsEndPDFContext()


        pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK,
            messageAs: fileURL.path + "/" + "\(pdfFileName!)"
        )

        self.commandDelegate!.send(
           pluginResult,
           callbackId: command.callbackId
        )
    }
}
