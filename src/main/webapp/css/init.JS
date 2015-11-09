//打开窗口的函数

 function switchSysBar(){
  if (parseInt(navigator.appVersion)>=4) {
	if (switchPoint.innerText==3){
		switchPoint.innerText=4
		document.all("query").style.display="none"

	}
	else{
		switchPoint.innerText=3
		document.all("query").style.display=""
	}
  }
}

 function viewPage(ipage){
        document.frmList.Page.value=ipage
        document.frmList.submit()        
     }

 function openScript(url, width, height) {
        var Win = window.open(url,"_blank",'width=' + width + ',height=' + height + ',resizable=0,scrollbars=no,menubar=no,status=no' );
    }

function openScript1(url, width, height) {
        var Win = window.open(url,"_blank",'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=no,left=5,top=10' );
    }

 function Detail(i,ss){
      var u
      u='newsdetail.asp?news_id='+i+'&wstr="'+ss+'"'
      window.open(u,'_blank','dependent,width=500,height=300')
    }
    
 function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,'width =503,height=316,resizable=1,scrollbars=yes,menubar=no,status=no,left=5,top=10');

    }

 function tt(s){
      alert(s)
    }

function OpenWindow(htmurl,widths,heights)
{
   var paramet = 'toolbar=no,resizable=yes,scrollbars=yes,width='+ widths + ',height=' + heights;
   newWindow = window.open(htmurl,"viewfilm",paramet);
   newWindow.focus();
}

function MM_openBrWindow1(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function tr1_onmouseover(index) {
   if(index>0){
	tr1(index).style.backgroundColor="#D6F3D6";
	tr1(index).style.color="#000000";}
}

function tr1_onmouseout(index) {
   if(index>0){
	if (0 == index % 2){
		tr1(index).style.backgroundColor="";
		tr1(index).style.color="black";
	}
	else
	{
		tr1(index).style.backgroundColor="#ebf3f5";
		tr1(index).style.color="black";
	}
}
}