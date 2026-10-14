// RIMS: Routine ImageJ Macro Suite 

// by Dr. Katrina Crompton, Universität zu Köln, SFB1607, Z02, 2026

// User chooses a routine task he wishes to apply to his image set and this macro carries out that task. 

macro "AutoRunAndHide" {  // runs once file is selected from the 'More Tools' >> dropdown menu

// DETERMINE ROUTINE TASK 
Dialog.create("RIMS: Routine ImageJ Macro Suite");
items = newArray("Crop all images in folder", "Rename all images in folder", "Resize all images in folder", "Make all images in folder grayscale", "Transfer images to individual folders", "Change file format of images", "Convert .vsi to .tif for all images", "Turn video into individual images (frames)", "Turn image set into video frames");
Dialog.addRadioButtonGroup("Options", items, 9,1, "Crop all images in folder");
Dialog.show;
TASK = Dialog.getRadioButton();

// CROP ALL IMAGES IN FOLDER -------------------------------------------------------------------------------------------------------------------------
if (TASK == "Crop all images in folder") {

waitForUser("Open folder where your raw images are saved");	
inputFolder = getDirectory("Choose your input folder ");

// ESTABLISH OUTPUT FOLDER
OUTPUT_FOLDER = inputFolder + "/OUTPUT_FOLDER/";
File.makeDirectory(OUTPUT_FOLDER);

imageList = getFileList(inputFolder); // get list of image files in input folder

// user defines crop area for first image 
open(inputFolder+imageList[1]); // open first image
image=getImageID();
selectImage(image);
run("Enhance Contrast...", "saturated=0.5");
setTool("rectangle");
waitForUser("Draw ROI around image then click OK here");
// if no ROI has been selected 
if (selectionType() == -1) {
waitForUser("Draw ROI and THEN click OK here");
getSelectionBounds(x,y,width,height);
close();

// automatically loop through image files 
setBatchMode(true);
for (j=0; j<imageList.length; j++) // loop through image file list 
{
open(inputFolder + imageList[j]);
title = getTitle(); // identify image filename 
makeRectangle(x, y, width, height);
run("Crop");
saveAs("PNG", OUTPUT_FOLDER + File.separator + title);
run("Close All");
}
setBatchMode(false);
}
// if an ROI has been selected
else {
getSelectionBounds(x,y,width,height);
close();
setBatchMode(true);
for (j=0; j<imageList.length; j++) // loop through image file list 
{
open(inputFolder + imageList[j]);
title = getTitle(); // identify image filename 
makeRectangle(x, y, width, height);
run("Crop"); 
saveAs("PNG", OUTPUT_FOLDER + File.separator + title);
run("Close All");	
}
setBatchMode(false);
}
waitForUser("Task is complete. Cropped images are in output folder");
}

// RENAME ALL IMAGES IN FOLDER ------------------------------------------------------------------------------------------------------------------------
if (TASK == "Rename all images in folder") {

waitForUser("Open folder where your raw images are saved");	
inputFolder = getDirectory("Choose your input folder ");
// ESTABLISH OUTPUT FOLDER
OUTPUT_FOLDER = inputFolder + "/OUTPUT_FOLDER/";
File.makeDirectory(OUTPUT_FOLDER);

imageList = getFileList(inputFolder); // get list of image files in input folder

// record user text input for first file 
open(inputFolder + imageList[1]);
Dialog.create("Enter Text");
Dialog.addString("Type new filename here:", "");
Dialog.show();
inputTitle = Dialog.getString();
close();
//change the filenames of all images in input folder
setBatchMode(true);
imageList1 = getFileList(inputFolder);
for (j=0; j<imageList1.length; j++) // loop through input folder list
{
open(inputFolder + imageList1[j]);
newFileName = inputTitle + IJ.pad(j+1,3) + ".png";
saveAs("PNG", OUTPUT_FOLDER + newFileName);
close();
}
run("Close All");
setBatchMode(false);
waitForUser("Task is complete. Renamed images are in output folder");
}

// RESIZE ALL IMAGES IN FOLDER ------------------------------------------------------------------------------------------------------------------------
if (TASK == "Resize all images in folder") {

waitForUser("Open folder where your raw images are saved");	
inputFolder = getDirectory("Choose your input folder ");
// ESTABLISH OUTPUT FOLDER
OUTPUT_FOLDER = inputFolder + "/OUTPUT_FOLDER/";
File.makeDirectory(OUTPUT_FOLDER);

imageList = getFileList(inputFolder); // get list of image files in input folder

// open first image to define new size 
open(inputFolder + imageList[1]);
newWidth = getNumber("Type new image WIDTH (in pixels) here:", 0);
newHeight = getNumber("Type new image HEIGHT (in pixels) here:", 0);
close();

setBatchMode(true);
for (j=0; j<imageList.length; j++) // loop through image file list 
{
open(inputFolder + imageList[j]);
title = getTitle(); // identify image filename 
// resize all images in folder
run("Size...", "width=newWidth height=newHeight depth=1 constrain average interpolation=Bilinear");

saveAs("PNG", OUTPUT_FOLDER + File.separator + title);
close();
}
run("Close All");
setBatchMode(false);
waitForUser("Task is complete. Resized images are in output folder");
}

// MAKE ALL IMAGES IN FOLDER GRAYSCALE ------------------------------------------------------------------------------------------------------------------------
if (TASK == "Make all images in folder grayscale") {
	
waitForUser("Open folder where your raw images are saved");	
inputFolder = getDirectory("Choose your input folder ");
// ESTABLISH OUTPUT FOLDER
OUTPUT_FOLDER = inputFolder + "/OUTPUT_FOLDER/";
File.makeDirectory(OUTPUT_FOLDER);

setBatchMode(true);
rawImageFolderFileList=getFileList(inputFolder);
for (f=0; f<rawImageFolderFileList.length; f++) {
open(inputFolder + rawImageFolderFileList[f]);

rawImage1=getTitle();
setOption("ScaleConversions", true);
run("8-bit");
rawImage2=getImageID();

// SAVE GRAYSCALE IMAGES TO OUTPUT FOLDER
selectImage(rawImage2);
saveAs("PNG", OUTPUT_FOLDER+File.separator+rawImage1);
run("Close All");
}

setBatchMode(false);
waitForUser("Task is complete. Grayscale images are in output folder");
}

// TRANSFER IMAGES TO INDIVIDUAL FOLDERS ------------------------------------------------------------------------------------------------------------------------
if (TASK == "Transfer images to individual folders") {

waitForUser("Open folder where your raw images are saved");	
inputFolder = getDirectory("Choose your input folder");

imageList = getFileList(inputFolder); // get list of image files in input folder

setBatchMode(true);
for (j=0; j<imageList.length; j++) // loop through image file list 
{
open(inputFolder + imageList[j]);
// isolate filename from file extension 
fileName = imageList[j];
fileName = getTitle();

if (endsWith(fileName, ".png")) {
fileNameWithoutExtension = replace(fileName, ".png", "");
// establish subfolder with filename 
imageSubFolder = inputFolder + fileNameWithoutExtension + "/";
File.makeDirectory(imageSubFolder);
// move image file to the new subfolder 
File.rename(inputFolder + fileName, imageSubFolder + fileName);
}

if (endsWith(fileName, ".tif")) {
fileNameWithoutExtension = replace(fileName, ".tif", "");
// establish subfolder with filename 
imageSubFolder = inputFolder + fileNameWithoutExtension + "/";
File.makeDirectory(imageSubFolder);
// move image file to the new subfolder 
File.rename(inputFolder + fileName, imageSubFolder + fileName);
}

if (endsWith(fileName, ".jpg")) {
fileNameWithoutExtension = replace(fileName, ".tif", "");
// establish subfolder with filename 
imageSubFolder = inputFolder + fileNameWithoutExtension + "/";
File.makeDirectory(imageSubFolder);
// move image file to the new subfolder 
File.rename(inputFolder + fileName, imageSubFolder + fileName);
}

if (endsWith(fileName, ".bmp")) {
fileNameWithoutExtension = replace(fileName, ".tif", "");
// establish subfolder with filename 
imageSubFolder = inputFolder + fileNameWithoutExtension + "/";
File.makeDirectory(imageSubFolder);
// move image file to the new subfolder 
File.rename(inputFolder + fileName, imageSubFolder + fileName);
}

}
run("Close All");
setBatchMode(false);
waitForUser("Task is complete. Individual image folders have been created");
}

// CHANGE FILE FORMAT OF IMAGES ------------------------------------------------------------------------------------------------------------------------
if (TASK == "Change file format of images") {

Dialog.create("Choose format");
items2 = newArray("PNG format", "TIFF format", "JPEG format", "BMP format");
Dialog.addRadioButtonGroup("Options", items2, 4,1, "PNG format");
Dialog.show;
TASK2 = Dialog.getRadioButton();

if (TASK2 == "PNG format") {
	
waitForUser("Open folder where your raw images are saved");	
inputFolder = getDirectory("Choose your input folder ");

// ESTABLISH OUTPUT FOLDER
OUTPUT_FOLDER = inputFolder + "/OUTPUT_FOLDER/";
File.makeDirectory(OUTPUT_FOLDER);

imageList = getFileList(inputFolder); // get list of image files in input folder

setBatchMode(true);
for (j=0; j<imageList.length; j++) // loop through image file list 
{
open(inputFolder + imageList[j]);

// PNG FORMAT
rawImage1=getTitle();
saveAs("PNG", OUTPUT_FOLDER+File.separator+rawImage1);
run("Close All");
}
setBatchMode(false);
waitForUser("Task is complete. Image file formats have been converted");
}

if (TASK2 == "TIFF format") {
	
waitForUser("Open folder where your raw images are saved");	
inputFolder = getDirectory("Choose your input folder ");
// ESTABLISH OUTPUT FOLDER
OUTPUT_FOLDER = inputFolder + "/OUTPUT_FOLDER/";
File.makeDirectory(OUTPUT_FOLDER);

imageList = getFileList(inputFolder); // get list of image files in input folder
setBatchMode(true);
for (j=0; j<imageList.length; j++) // loop through image file list 
{
open(inputFolder + imageList[j]);

// TIFF FORMAT
rawImage1=getTitle();
saveAs("TIFF", OUTPUT_FOLDER+File.separator+rawImage1);
run("Close All");
}
setBatchMode(false);
waitForUser("Task is complete. Image file formats have been converted");
}

if (TASK2 == "JPEG format") {

waitForUser("Open folder where your raw images are saved");	
inputFolder = getDirectory("Choose your input folder ");
// ESTABLISH OUTPUT FOLDER
OUTPUT_FOLDER = inputFolder + "/OUTPUT_FOLDER/";
File.makeDirectory(OUTPUT_FOLDER);

imageList = getFileList(inputFolder); // get list of image files in input folder

setBatchMode(true);
for (j=0; j<imageList.length; j++) // loop through image file list 
{
open(inputFolder + imageList[j]);

// JPEG FORMAT
rawImage1=getTitle();
saveAs("Jpeg", OUTPUT_FOLDER+File.separator+rawImage1);
run("Close All");
}
setBatchMode(false);
waitForUser("Task is complete. Image file formats have been converted");
}

if (TASK2 == "BMP format") {
	
waitForUser("Open folder where your raw images are saved");	
inputFolder = getDirectory("Choose your input folder ");
// ESTABLISH OUTPUT FOLDER
OUTPUT_FOLDER = inputFolder + "/OUTPUT_FOLDER/";
File.makeDirectory(OUTPUT_FOLDER);

imageList = getFileList(inputFolder); // get list of image files in input folder
setBatchMode(true);
for (j=0; j<imageList.length; j++) // loop through image file list 
{
open(inputFolder + imageList[j]);

// BMP FORMAT
rawImage1=getTitle();
saveAs("BMP", OUTPUT_FOLDER+File.separator+rawImage1);
run("Close All");
}
setBatchMode(false);
waitForUser("Task is complete. Image file formats have been converted");
}
}

// CONVERT .vsi TO .tif FOR ALL IMAGES -------------------------------------------------------------------------------------------------------------------------
if (TASK == "Convert .vsi to .tif for all images") {

waitForUser("Open folder where your .vsi images are saved");	
inputFolder = getDirectory("Choose your input folder ");

// ESTABLISH OUTPUT FOLDER
TIFF_VERSIONS = inputFolder + "/TIFF_VERSIONS/";
File.makeDirectory(TIFF_VERSIONS);

setBatchMode(true);
imageList = getFileList(inputFolder); // get list of image files in input folder

for (j = 0; j < imageList.length; j++) {

    if (endsWith(toLowerCase(imageList[j]), ".vsi")) {
    	
 // isolate filename from .vsi extension 
        baseName = imageList[j];
        dot = lastIndexOf(baseName, ".");
        if (dot > 0)
            baseName = substring(baseName, 0, dot);

// open files and split channels/stacks  
        run("Bio-Formats Importer",
            "open=[" + inputFolder + imageList[j] + "] " +
            "color_mode=Default " +
            "view=Hyperstack " +
            "stack_order=XYCZT");

// isolate image dimensions 
        getDimensions(width, height, channels, slices, frames);

// identify raw image 
        originalID = getImageID();

// split channels 
        run("Split Channels");
        // Close original hyperstack
        if (isOpen(originalID)) {
            selectImage(originalID);
            close();
        }

// save channels as .tif images with file basename 
        for (c = 1; c <= channels; c++) {
            channelID = -1;
            // Search all open images
            for (m = 1; m <= nImages; m++) {
                selectImage(m);
                title = getTitle();
                if (startsWith(title, "C" + c + "-")) {
                    channelID = getImageID();
                    break;
                }
            }
            // Save channel
            if (channelID != -1) {
                selectImage(channelID);
                saveAs("Tiff", TIFF_VERSIONS + baseName + "_C" + c + ".tif");
                close();
            } else {
                print("  ERROR: Channel " + c + " not found!");
            }
        }
    }
}
setBatchMode(false);
waitForUser("Task is complete. Converted images are in output folder");
}

// TURN SINGLE VIDEO INTO MULTIPLE IMAGES (FRAMES) ----------------------------------------------------------------------------------------------------
if (TASK == "Turn video into individual images (frames)") {

waitForUser("Open folder where your video is saved");	
inputFolder = getDirectory("Choose your input folder ");
// ESTABLISH OUTPUT FOLDER
OUTPUT_FOLDER = inputFolder + "/OUTPUT_FOLDER/";
File.makeDirectory(OUTPUT_FOLDER);

videoList = getFileList(inputFolder); // get list of image files in input folder
setBatchMode(true);

for (v=0; v<videoList.length; v++) {
	fileName = videoList[v];

if(!(endsWith(fileName, ".avi") || endsWith(fileName, ".mp4") || endsWith(fileName, ".tif"))) {
	continue;
}
open(inputFolder + fileName);

// remove extension from filename
period = lastIndexOf(fileName, ".");
fileNameWithoutExtension = substring(fileName, 0, period);

nFrames = nSlices;

// separate into frames and save into output folder 
for (f=1; f<=nFrames; f++) {
setSlice(f);
frameName = fileNameWithoutExtension + "_frame" + IJ.pad(f,3) + ".png";
saveAs("PNG", OUTPUT_FOLDER + frameName);
}
close();
}
run("Close All"); 
setBatchMode(false);
waitForUser("Task is complete. Video frames are in output folder");
}

// TURN MULTIPLE IMAGES INTO FRAMES OF SINGLE VIDEO ----------------------------------------------------------------------------------------------------
if (TASK == "Turn image set into video frames") {

waitForUser("Open folder where your raw images are saved");
inputFolder = getDirectory("Choose your input folder");
// ESTABLISH OUTPUT FOLDER
OUTPUT_FOLDER = inputFolder + "/OUTPUT_FOLDER/";
File.makeDirectory(OUTPUT_FOLDER);

frameList = getFileList(inputFolder);

// user creates video filename 
open(inputFolder + frameList[1]);
Dialog.create("RIMS: Routine ImageJ Macro Suite");
Dialog.addString("Type new video filename here:", "");
Dialog.show();
inputTitle = Dialog.getString();
close();

// only works if the images have the same dimensions 
run("Image Sequence...", "open=[" + inputFolder + "] sort");

outputPath = OUTPUT_FOLDER + inputTitle + ".avi";
run("AVI... ", "compression=None frame=10 save=[" + outputPath + "]");

run("Close All");
waitForUser("Task is complete. Video is in output folder");
}




}