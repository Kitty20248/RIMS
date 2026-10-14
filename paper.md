title:  RIMS: Routine ImageJ Macro Suite 
tags: 
  - ImageJ (FIJI)
  - image-processing 
authors: 
   - Name: Katrina Crompton
     orcid: 0009-0007-9336-328X
     equal-contrib: true
     affiliation: Department of Ophthalmology, University of Cologne, Faculty of Medicine and University Hospital Cologne, University of Cologne, Cologne, Germany 
date: 14 October 2026

# Summary 

Routine ImageJ Macro Suite (RIMS) is a collection of kernels in one macro written in ImageJ macro script. Upon running the script, the user can choose from 9 different fully-automatic file-processing tasks including cropping, renaming or resizing all images in a folder, making all images in a folder grayscale, changing the file format of all images in a folder, converting .vsi image-files to .tif, transferring images to individual folders and converting videos to individual image frames or vice versa. 

# Statement of need

RIMS addresses the frequent arduous requirements faced by researchers of image reformatting before they can be analysed using other image-analysis softwares or be used in training networks, making performing these tasks fast and easy. RIMS is a macro written in ImageJ macro script which can be easily used by researchers with little to no programming experience thanks to its dialogue and instruction boxes. Image formatting is completed in Batch mode and can be carried out on Folders containing 2 to hundreds of imagefiles. RIMS is a macro instead of a plugin, therefore does not require multiple downloads. The macro suite itself is 14KB and can even be shared between researchers and groups via email. Use is self-explanatory with the help of instructions in dialog boxes and so instructions are only required for the initial download and saving of the macro file. 

# State of the field 

Of course, macros of an image-analysis nature can be created in a great number of softwares specifically designed for image analysis, usually concurrently controlling microscopy tools, including Zeiss ZEN (“ZEISS,” 2023), CellSens, Nikon Elements and IMARIS. Further softwares do this with data, such as Microsoft Excel (Ji and Hu, 2024). However, all of these softwares require paid licenses and are restrictive in what users can and cannot do. There exist too several opensource simulacrums of these platforms allowing users, free of charge, to analyse image files in batch mode including Ilastik (Sommer et al., 2011), CellProfiler (Carpenter et al., 2006) and ICY (de Chaumont et al., 2011). Additionally, opensource script environments exist including Python (Thangarajah, 2019), C-free (“C-Free,” 2023) and R (“R+,” 2011) allowing users to create entirely new image- and data-analysis scripts from scratch. Although these opensource softwares are free of charge and available on most operating systems, they require at least a basic knowledge of programming for amateur use, leading to advanced competence for full manipulation of code and associated environments. Pre-existing macro suites easily available for download, requiring no prior knowledge of programming, are useful in image-associated research. RIMS is exactly this, offering 9 solutions to routine file processing. It is the ideal tool for modifying images and associated masks for later use in neural network training. 

# Software design 

Upon starting, RIMS displays a textbox menu (figure 1B) prompting the user to choose the task to be carried out. These tasks include; Crop all images in folder, Rename all images in folder, Resize all images in folder, Make all images in folder grayscale, Transfer images to individual folders  , Change file format of images, Convert .vsi to .tif, Turn video into individual images (frames), Turn image set into video Frames. 
RIMS is written using ImageJ Macro Script and has 9 radio buttons, unique for each task. Upon selecting a task, the user is prompted to find the input folder. After doing this, the macro works automatically over the entire folder of images. When the task is finished, a textbox appears informing the user that the task is completed and that new files are saved in an output folder. 
Crop all images in folder 
This task is performed when the user wishes to crop an area of interest in all images of the same dimensions in the same image folder. This task may be performed when, for example segmenting the cornea and anterior chamber area in a series of OCT B-Scans. Firstly, the user is prompted to select the folder containing images, namely the input folder. The first image from the input folder is opened and the user is asked to draw a rectangular region of interest (ROI) over it. The coordinates, width and height of the ROI are recorded and then applied automatically to each image in the set . This task works in batch mode and an output folder is automatically created within this and is where the cropped images are subsequently saved.
Rename all images in folder
This task is performed when a user would like to change the name of all image files in a folder. After the user chooses the input folder, a dialog box instructs the user to type their new filename. After this the macro applies this name automatically to all images in the folder with an incrementing index at the end of the filename before the file extension of the form 000N where N is the Nth image. Working in batch mode, the renamed images are saved in an automatically produced output folder. The benefit of carrying out this task in RIMS instead of by using another software is that the task can be found in an easy-to-read list and executed in same software one would later use to analyse the images. 
Resize all images in folder
This task is performed when the user wishes to alter the width and height (in pixels) of the image, for all images in a folder. After the user chooses the input folder, two consecutive dialog boxes instruct the user to input the desired height and width. After this, the macro automatically opens all images in a folder and resizes them according to the new dimensions saving them in an automatically created output folder. 
Make all images in folder grayscale 
A task performed when the user requires all images in a folder to be 8-bit. After choosing the input folder, the macro automatically reads all images, converts them to 8-bit and then saves them of the same name in an automatically created output folder. 
Transfer images to individual folders
This task allows a user to quickly, automatically create individual folders for each image of the image file name and move the image to within this new folder. An example of when this task may be performed is when a user wishes to make multiple ROIs of each image in a folder. First, the raw images must be saved to their own folders. For this task, the user must only choose the input folder, the rest is carried out automatically by the macro. 
Change file format of images 
Images from the chosen input folder are converted to a desired file format. Options for conversions provided are .tif, .jpg, .png and .bmp. The user chooses the desired file format from a textbox menu and all images are converted and saved in an automatically created output folder. The original files are left untouched. 
Convert .vsi to .tif
Images from an input folder containing .vsi files are split into stacks and each stack is save as a .tif file of the same filename as the original .vsi file with a 000N at the end whereby N is the Nth stack. The .tif files are saved in an output folder. The original files are left untouched.
Turn image video into individual images (frames)
With this task the user can separate the frames of a video into individual images. All that is asked of the user during this macro is to choose the input folder. The macro works automatically on stacked .tif files or .avi video files, saving each frame as an individual image of the video file name with an incrementing index at the end of the filename before the file extension of the form 00n where n is the nth frame. These are saved in an automatically created output folder.  
Turn image set into video frames 
The user can use this task to combine multiple images of the same spatial dimensions into a video. After choosing the input folder, the user is prompted to input a filename for the new video. The macro then automatically creates a sequence of the images and saves an .avi video file with the inputted name in the automatically created output folder.   

# Research Impact Statement 

RIMS already helps our research group process large quantities of imagefiles for use in training networks. Once the RIMS open source paper is published, it is projected that RIMS will be downloaded significantly often by groups to perform image-processing tasks in large quantities at a faster rate. 

# References 

Carpenter, A.E., Jones, T.R., Lamprecht, M.R., Clarke, C., Kang, I.H., Friman, O., Guertin, D.A., Chang, J.H., Lindquist, R.A., Moffat, J., Golland, P., Sabatini, D.M., 2006. CellProfiler: image analysis software for identifying and quantifying cell phenotypes. Genome Biol. 7, R100. https://doi.org/10.1186/gb-2006-7-10-r100
C-Free, 2023.
de Chaumont, F., Dallongeville, S., Olivo-Marin, J.-C., 2011. ICY: A new open-source community image processing software, in: 2011 IEEE International Symposium on Biomedical Imaging: From Nano to Macro. Presented at the 2011 IEEE International Symposium on Biomedical Imaging: From Nano to Macro, pp. 234–237. https://doi.org/10.1109/ISBI.2011.5872395
Ji, X., Hu, B., 2024. Macros in Excel. E3S Web Conf. 522, 01040. https://doi.org/10.1051/e3sconf/202452201040
R+, 2011.
Sommer, C., Straehle, C., Köthe, U., Hamprecht, F.A., 2011. Ilastik: Interactive learning and segmentation toolkit, in: 2011 IEEE International Symposium on Biomedical Imaging: From Nano to Macro. Presented at the 2011 IEEE International Symposium on Biomedical Imaging: From Nano to Macro, pp. 230–233. https://doi.org/10.1109/ISBI.2011.5872394
Thangarajah, V., 2019. Python current trend applications-an overview.
ZEISS, 2023. . Microsc. Today 31, 26. https://doi.org/10.1093/mictod/qaad007.023








