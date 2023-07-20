# General utilities
* `cap.m`: cap a value between lower and upperbounds.
* `scap.m`: symmetrically `cap` a value.
* `cellmask.m`: logical mask for cell arrays.
* `clearfield.m`: removes a field in a structure, if it exists.
* `startup.m`: startup script.
* `gA.m`: make it gpu array if gpu is available.
* `gAzeros.m`: gA(zeros(...)).
* `gather_fields.m`: broadcast `gather` over fields of a structure.
* `if_then_else.m`: (eager) switch logic friendly to arrays.
* `PACKWS.m`: script that packs all variables to structure PACKWS_SV.
* `unpack_struct.m`: export fields of a structure as variables to current workspace.
* `range_dim`: array indexing at a given dimension for arrays of indefinite total dimension.


# Math & computations
* `cispi.m`: cospi + 1i*sinpi.
* `eig2x2.m`: get eigenvalue and eigenspace of 2x2 matrices in batch / pages.
* `inv2x2.m`: invert a batch of 2x2 matrices, similar to pageinv.
* `fftconv.m`: FFT convolution, or cconv, of vectors or arrays along the 1st dimension.
* `fftconv2.m`: FFT convolution of matrices.
* `functionError.m`: compute difference, i.e. error, across to arrays of the same size.
* `interpshift.m`: shift array with interpolation and fall offs. 
* `power_law_fit.m`: fit data with power law.


# Plot control
* `allaxes.m`: gets handle for all axes in figure handle fh, including children of tiledlayout.
* `autozoom.m`: returns the range of array indices that constitutes the nonzero bulk.
* `axinbound.m`: ensures that axis range has a minimal span.
* `axoutbound.m`: ensures that axis range does not exceed maximal span.
* `fig2clip.m`: paste figure to clipboard. Useful when GUI is slow.
* `figDefaultKeyPress.m`: figure control keys. used in combination with startup.m. Original code copied from elsewhere.
* `fq.m`, `fqq.m`: (obsolete) tools to safety close plot windows. Useful when GUI is slow and back when matlab is buggy.
* `pretty_fig.m`: attempt to make figures nicer, with larger text, etc.
* `pub_square_fig.m`: make a single figure square and hopefully publication quality?
* `recolor.m`: recolor lines in plot from red to blue by `turbo` colormap.
* `restyle.m`: change line style of lines to - -- -: -. and repeat.
* `tiledfig_resize.m`: Resize a figure to about a square linear dimension for each tile.


# Colormaps and image plots
* `cmaprb.m`: gives a red-white-blue colormap for positive-zero-negative values.
* `cmap_angle.m`: return a NIST hsv colormap, useful for displaying angles or other periodic data.
* `setcolormap_angle.m`: set colormap according to `cmap_angle` cropped by actual values.
* `cmap_angle_demo.m`: a demo for `cmap_angle` colormap.
* `imagerb.m`: imagesc with `cmaprb` colormap and colorbar.
* `imagerb_interp.m`: imagerb with interpolation of data to make them uniform for proper display.
* `logticks_ensure_dec.m`: ensures tick marks every decade on a log axis.
* `pcolorb.m`: pcolor with colormap `cmaprb`.

# Cluster user utilities
* `getenv_ncpu.m`: read from environment `MATLAB_NCPU`.
* `start_pool_env.m`: read from environment `MATLAB_NCPU` and set parallel pool cpu number. Useful for cluster jobs.
* `printsix.m`: (incomplete) display plot using sixel.