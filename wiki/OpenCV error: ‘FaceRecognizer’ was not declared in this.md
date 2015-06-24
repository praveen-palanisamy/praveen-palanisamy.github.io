##error: ‘FaceRecognizer’ was not declared in this scope

If you ever get this error with OpenCV, it can be solved using either of the two simple includes mentioned below:

* If your OpenCV version is below 3.0 (and above 2.xx)
		Then, adding `#include "opencv2/contrib/contrib.hpp"`
* If your OpenCV version is 3.0 and up,
		Then, instead of `#include "opencv2/contrib/contrib.hpp"` add `#include "opencv2/face.hpp"	and instead of `FaceRecognizer` use `cv::face::FaceRecognizer` in the code.

