//code for different strategies of detecting iOS devices i.e. iPad, iPhone, iPod to allow for different drag and drop code to be used for iOS devices


//using regular expressions
var iOS = ( navigator.userAgent.match(/(iPad|iPhone|iPod)/i) ? true : false );

//without regular expressions
var iOS = false,
    p = navigator.platform;

if( p === 'iPad' || p === 'iPhone' || p === 'iPod' ){
    iOS = true;
}

//version to help with adding new devices easily
var i = 0,
    iOS = false,
    iDevice = ['iPad', 'iPhone', 'iPod'];

for ( ; i < iDevice.length ; i++ ) {
    if( navigator.platform === iDevice[i] ){ iOS = true; break; }
}

//it is best to check the type of device not the browser version it is using