# Voronoi - drawings

## How to

### Running

1. Run `main.red`.
2. In the tab `Sites` add some sites by clicking on the silver canvas.
3. Change tab to the `Voronoi`, choice method from the list and click `calc voronoi`.
4. Wait.

### Colors

In the tab `Colors` you can add or change colors.   
At the moment, in order to see the changes you have to (re)calculate voronoi (`voronoi` tab > `calc voronoi`).

### Options

- Canvas size

### Exporting

You can export:
- Image as `png` file
- Points as `txt` file
- Sites as `txt` file

### Importing

You can import sites by pasting list of `pair!`s (e.g. `91x136 200x197 170x250`) in the `Sites`' tab field.

### Distances (functions)

At the moment, you can preview function used to calculate distances between sites.


## Bugs and future feature

Create `issue` in the github's issue tracker.
The [_feature-sandbox](/_feature-sandbox) directory may contain features not yet implemented.

## Versions

### **0.0.1 alpha**:
This version was conversion from my old Rebol code. It has been not edited for a long time. However it works more or less so I decided to share it. Expect bugs.

Features:
- calculating voronoi
- adding or changing colors
- previewing of the distance functions
- exporting (image, sites, points)
- setting size (require more testing)


## License

See [license.md](/license.md)
