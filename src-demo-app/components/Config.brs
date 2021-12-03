' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********
'
' Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

function loadConfig() as object
    arr = [
        '##### Format for inputting stream info #####
        '## For each channel, enclose in brackets ##
        '{
        '   Title: Channel Title
        '   streamFormat: Channel stream type (ex. "hls", "ism", "mp4", etc..)
        '   Logo: Channel Logo (ex. "http://Roku.com/Roku.jpg)
        '   Stream: URL to stream (ex. http://hls.Roku.com/talks/xxx.m3u8)
        '}

        {
            Title: "Big Buck Bunny"
            ContentType: "movie"
            streamFormat: "mp4"
            Logo: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg"
            Stream: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        }
        {
            Title: "Elephant Dream"
            streamFormat: "mp4"
            Logo: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg"
            Stream: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
        }
        {
            Title: "Sintel"
            streamFormat: "mp4"
            Logo: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/Sintel.jpg"
            Stream: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
        }
        {
            Stream: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"
            streamFormat: "mp4"
            Logo: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/TearsOfSteel.jpg"
            Title: "Tears of Steel"
        }
        {
            Stream: "http://commondatastorage.googleapis.com/wrongUrl/raisesError.mp4"
            streamFormat: "mp4"
            Title: "Error"
        }

        '##### Make sure all Channel content is above this line #####
    ]
    return arr
end function
