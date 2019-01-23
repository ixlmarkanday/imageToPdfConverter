package com.imagetopdfconverter;

import android.content.Context;
import android.content.ContextWrapper;

import com.itextpdf.text.Document;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import android.os.Environment;

/**
 * This class echoes a string called from JavaScript.
 */
public class ImageToPDFConverter extends CordovaPlugin {
  private File pdfFile;

  @Override
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
    if (action.equals("createPdf")) {
      JSONArray array0 = args.getJSONArray(0);
      String name = args.getString(1);
      this.createPdf(array0, name, callbackContext);
      return true;
    }
    return false;
  }

  private void createPdf(JSONArray args, String name, CallbackContext callbackContext) {
    if (args != null && args.length() > 0) {
      int arraySize = args.length();
      //ContextWrapper cw = new ContextWrapper(cordova.getContext());
      //File directory = cw.getDir("imageDir", Context.MODE_PRIVATE);
      File docsFolder = new File(Environment.getExternalStorageDirectory() + "/MyPdf");
      if (!docsFolder.exists()) {
          docsFolder.mkdir();
      }
      try {
        //pdfFile = new File(directory, name);
        pdfFile = new File(docsFolder.getAbsolutePath(), name);
        OutputStream output = new FileOutputStream(pdfFile);
        Document document = new Document();
        PdfWriter.getInstance(document, output);
        document.open();
        for (int i = 0; i < arraySize; i++) {
          try {
            Image image = Image.getInstance(String.valueOf(args.get(i)));
            image.setCompressionLevel(1);
            image.setAlignment(Image.MIDDLE);
            image.setBorder(Image.BOX);
            image.scaleToFit(640f, 480f);
            image.setBorderWidth(1);
            document.add(image);
            document.add(new Paragraph(""));
          } catch (Exception e) {
            e.printStackTrace();
          }
        }
        document.close();
      } catch (Exception e) {
        e.printStackTrace();
      }
      callbackContext.success(pdfFile.getPath());
    } else {
      callbackContext.error("Expected one non-empty string argument.");
    }
  }
}
