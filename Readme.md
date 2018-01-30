Standard element Image Index Slider render handler
==================================================

Options
-------

### Image Index

-   `auto-play-<integer>`  
    Automatically advance to the next slide at the given interval.  
    (In milliseconds.)

-   `background-color-<hex>`  
    The color behind all the slides.  
    (Use 3, 4, 6 or 8-digit hexadecimal notation without a pound sign.)  
    (Use &ldquo;transparent&rdquo; for no color.)

### Photo

-   `background-color-<hex>`  
    The color behind the image and caption (if visible).  
    (Use 3, 4, 6 or 8-digit hexadecimal notation without a pound sign.)  
    (The selected theme must support this feature.)

-   `caption-background-color-<hex>`  
    The color behind the caption.  
    (Use 3, 4, 6 or 8-digit hexadecimal notation without a pound sign.)  

### Title

-   `color-<hex>`  
    The color of the titular text.  
    (Use 3, 4, 6 or 8-digit hexadecimal notation without a pound sign.)

-   `size-<int>`  
    The size of the tituar text.  
    (In pixels.)

-   `visible`  
    Add a caption with a title to every image.  
    (Blank titles are not displayed.)

### Description

-   `color-<hex>`  
    The color of the descriptive text.  
    (Use 3, 4, 6 or 8-digit hexadecimal notation without a pound sign.)

-   `size-<int>`  
    The size of the descriptive text.  
    (In pixels.)

-   `visible`  
    Add a caption with a description to every image.  
    (Blank descriptions are not displayed.)  
    (Description must be different from the title to be visible.)

Examples
--------

[View examples](./examples/)

How it Works
------------

-   Subject
    -   Keeps the images around the same aspect ratio
    -   `max-width: 100% * (<this aspect ratio> / <widest aspect ratio>)`
-   Link
    -   Keeps the imges around the same height
    -   `max-width: <shortest image height> / <inverse aspect ratio>`
-   Image
    -   Keeps the images from overflowing their containers
    -   `max-width: 100%`
