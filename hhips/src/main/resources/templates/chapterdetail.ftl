<html>
<head>
	<meta charset="utf-8"/>
	<title>${chapterindex}--${chaptername}</title>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="./chart/highcharts.js"></script>
	<script type="text/javascript" src="./chart/piechart4problem.js"></script>
	<script type="text/javascript" src="./js/common.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
		<#include "/header.ftl">
		<table class="boldFont">
            <tr>
                <td>
                    <#if before != 0>
                        <div><a href="./Chapter?chapterid=${before?c}" style="text-decoration: none">前一章</a></div>
                    </#if></td>
                <td>
                    <#if after != 0>
                        <div><a href="./Chapter?chapterid=${after?c}" style="text-decoration: none">&nbsp;&nbsp;&nbsp;&nbsp;后一章</a></div>
                    </#if>
                </td>
            </tr>
        </table>
        <#include "/chapterheader.ftl">
		<table>
            <tr>
                <td>
                    <div id="container" style="width: 550px; height: 400px; margin: 0 auto"></div>
                </td>
            </tr>
        </table>
		<button type="button" onclick="addWhole2Paper(${chapterid})">Add all to Paper</button>
		<#if maxpaper != -1>
			<select id="paperselect">
				<#list 0..maxpaper as i>
					<option value=${papers[i].idpaper?c}>${papers[i].papername}</option>
				</#list>
			</select>
		</#if>
		<#if max != -1>
            <table class="dmmtable">
                <#list 0..max as i>
                    <tr>
                        <td>
                            <a class="jumper notLinkText" href="#jump_${problems[i].idproblem?c}">
                            <p>${problems[i].problemindex}&nbsp;&nbsp;</p>
                            </a>
                        </td>
                        <td>
                            <#if problems[i].problemlevel == 1>
                                <p>☆</p>
                            </#if>
                            <#if problems[i].problemlevel == 2>
                                <p>☆☆</p>
                            </#if>
                            <#if problems[i].problemlevel == 3>
                                <p>☆☆☆</p>
                            </#if>
                            <#if problems[i].problemlevel == 4>
                                <p>☆☆☆☆</p>
                            </#if>
                        </td>
                        <td>
                            <p>${problems[i].modulename}&nbsp;&nbsp;</p>
                        </td>

                            <#if problems[i].workdetail??>
                                <#if problems[i].workmark??>
                                    <#if problems[i].workmark == 0>
                                        <td><p class="right">通过</p></td>
                                    <#else>
                                        <td><p class="wrong">未通过</p></td>
                                    </#if>
                                <#else>
                                    <td><p class="orange">待批</p></td>
                                </#if>
                                <td>
                                    <p>${problems[i].workdate?string("yyyy-MM-dd")} &nbsp;&nbsp;&nbsp;</p>
                                </td>
                                <td>
                                    <p>${problems[i].problemtotalworktime?c} &nbsp;&nbsp;</p>
                                </td>
                                <td>
                                    <p>${problems[i].problemtotalusetime?c}</p>
                                </td>
                            <#else>
                                <td>
                                    <p>未做</p>
                                </td>
                            </#if>
                            <td>
                                <#list works[i] as work>
                                    <#if work.workmark??>
                                        <#if work.workmark == 0>
                                            <p style="height: 20px; float:left; width:${work.usedtime?c}0px;background-color:green">${work.usedtime?c}</p>
                                        <#else>
                                            <p style="height: 20px; float:left; width:${work.usedtime?c}0px;background-color:red">${work.usedtime?c}</p>
                                        </#if>
                                    <#else>
                                        <p style="height: 20px; float:left; width:${work.usedtime?c}0px;background-color:orange">${work.usedtime?c}</p>
                                    </#if>
                                </#list>

                            </td>
                        </tr>
                </#list>
            </table>
        </#if>
		<#if max != -1>
			<#list 0..max as i>
				<table>
					<span id=jump_${problems[i].idproblem?c}></span>
					<tr>
						<td>
							<p>${problems[i].problemindex}</p>
						</td>
						<td>
							<p>${problems[i].modulename}</p>
						</td>
						<td>
							<button type="button" class="normalButton" onclick="deleteProblem(${problems[i].idproblem?c})">Delete</button>
						</td>
						<td>
							<p>${problems[i].problemlevel}</p>
						</td>
						<td>
							<#if problems[i].problemcisactive != 0>
								<button type="button" id=active_${problems[i].idproblem?c}" class="activeButton" onclick="activeProblem(${problems[i].idproblem?c}, 0)">Deactive</button>
							<#else>
								<button type="button" id=active_${problems[i].idproblem?c}" class="normalButton" onclick="activeProblem(${problems[i].idproblem?c}, 5)">Active</button>
							</#if>
						</td>
						<td>
                            <div class="picked" onclick="window.open('./Problem?problemid=${problems[i].idproblem?c}')">
							<img id="myImage" class="center-fit" src=.\${problems[i].problemdetail} />
							<#if problems[i].problemdetailb??>
							    <img id="myImage" class="center-fit" src=.\${problems[i].problemdetailb} />
							</#if>
							<#if problems[i].problemdetailc??>
                                <img id="myImage" class="center-fit" src=.\${problems[i].problemdetailc} />
                            </#if>
                            </div>
						</td>
					</tr>	
				</table>
				<table>					
					<tr>
						<td>
							<#if problems[i].idwork??>
								<p>${problems[i].workdate?string("yyyy-MM-dd")} --- ${problems[i].usedtime?c}</p>
								<#if problems[i].workmark??>
									<#if problems[i].workmark == 0>
										<p class="right">-------Pass-------</p>
									<#else>
										<p class="wrong">------Not Pass----</p>
									</#if>
								</#if>
							<#else>
								<p>no work recorder</p>
							</#if>
						</td>
					</tr>
				</table>
				<table>					
					<tr>
						<td>
							<img id="answer" class="center-fit" src=.\${problems[i].problemanswerdetail} />
						</td>
					</tr>
					<tr>
						<td>
							<br></br>
						</td>
						<td>
							<br></br>
						</td>
					</tr>
				</table>
				
			</#list>
		</#if>
		<table>
			<tr>
				<td>
					<input type="text" id="answerstring" />
				</td>
			</tr>

			<tr>
				<td>
					<div class="preview_box" id="problemview"></div>
				</td>
			</tr>
			<tr>
                <td>
                    <div class="preview_box" id="problemviewb"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="preview_box" id="problemviewc"></div>
                </td>
            </tr>
			<tr>
				<td>
					<div class="preview_box" id="answerview"></div>
				</td>
			</tr>
			<tr>
                <td>
                    <select id="moduleselect">
                        <#list 0..maxmodule as i>
                            <option value=${modules[i].idmodule}>${modules[i].modulename}</option>
                        </#list>
                    </select>
                    <select id="levelselect">
                        <option value=1>1</option>
                        <option value=2>2</option>
                        <option value=3 selected = "selected">3</option>
                        <option value=4>4</option>
                    </select>
                    <select id="indexselect">
                        <option value="L1">L1</option>
                        <option value="L2">L2</option>
                        <option value="L3">L3</option>
                        <option value="L4">L4</option>
                        <option value="L5">L5</option>
                        <option value="L6">L6</option>
                        <option value="L7">L7</option>
                        <option value="L8">L8</option>
                        <option value="L9">L9</option>
                        <option value="L10">L10</option>
                        <option value="L11">L11</option>
                        <option value="L12">L12</option>
                        <option value="L13">L13</option>
                        <option value="L14">L14</option>
                        <option value="L15">L15</option>
                        <option value="L16">L16</option>
                        <option value="L17">L17</option>
                        <option value="L18">L18</option>
                        <option value="L19">L19</option>
                        <option value="L20">L20</option>
                        <option value="L21">L21</option>
                        <option value="L22">L22</option>
                        <option value="L23">L23</option>
                        <option value="L24">L24</option>
                        <option value="L25">L25</option>
                        <option value="L26">L26</option>
                        <option value="L27">L27</option>
                        <option value="L28">L28</option>
                        <option value="L29">L29</option>
                        <option value="L30">L30</option>
                        <option value="L1L">L1L</option>
                        <option value="L2L">L2L</option>
                        <option value="L3L">L3L</option>
                        <option value="L4L">L4L</option>
                        <option value="L5L">L5L</option>
                        <option value="L6L">L6L</option>
                        <option value="L7L">L7L</option>
                        <option value="L8L">L8L</option>
                        <option value="L9L">L9L</option>
                        <option value="Z01">Z01</option>
                        <option value="Z02">Z02</option>
                        <option value="Z03">Z03</option>
                        <option value="Z04">Z04</option>
                        <option value="Z05">Z05</option>
                        <option value="Z06">Z06</option>
                        <option value="Z07">Z07</option>
                        <option value="Z08">Z08</option>
                        <option value="Z09">Z09</option>
                        <option value="Z10">Z10</option>
                        <option value="Z11">Z11</option>
                        <option value="Z12">Z12</option>
                        <option value="Z13">Z13</option>
                        <option value="Z14">Z14</option>
                        <option value="Z15">Z15</option>
                        <option value="Z16">Z16</option>
                        <option value="Z17">Z17</option>
                        <option value="Z18">Z18</option>
                        <option value="Z19">Z19</option>
                        <option value="Z20">Z20</option>
                        <option value="Z21">Z21</option>
                        <option value="Z22">Z22</option>
                        <option value="Z23">Z23</option>
                        <option value="Z24">Z24</option>
                        <option value="Z25">Z25</option>
                        <option value="Z26">Z26</option>
                        <option value="Z27">Z27</option>
                        <option value="Z28">Z28</option>
                        <option value="Z29">Z29</option>
                        <option value="Z30">Z30</option>
                        <option value="J01">J01</option>
                        <option value="J02">J02</option>
                        <option value="J03">J03</option>
                        <option value="J04">J04</option>
                        <option value="J05">J05</option>
                        <option value="J06">J06</option>
                        <option value="J07">J07</option>
                        <option value="J08">J08</option>
                        <option value="T01">T01</option>
                        <option value="T02">T02</option>
                        <option value="T03">T03</option>
                        <option value="T04">T04</option>
                        <option value="T05">T05</option>
                        <option value="T06">T06</option>
                        <option value="T07">T07</option>
                        <option value="T08">T08</option>
                        <option value="T09">T09</option>
                        <option value="T10">T10</option>
                        <option value="T11">T11</option>
                        <option value="T12">T12</option>
                        <option value="T13">T13</option>
                        <option value="T14">T14</option>
                        <option value="C01">C01</opCion>
                        <option value="C02">C02</opCion>
                        <option value="C03">C03</opCion>
                        <option value="C04">C04</opCion>
                        <option value="C05">C05</opCion>
                        <option value="C06">C06</opCion>
                        <option value="C07">C07</opCion>
                        <option value="C08">C08</opCion>
                        <option value="C09">C09</opCion>
                        <option value="C10">C10</opCion>
                        <option value="C11">C11</option>
                        <option value="C12">C12</option>
                        <option value="C13">C13</option>
                        <option value="C14">C14</option>
                        <option value="C15">C15</option>
                        <option value="C16">C16</option>
                        <option value="C17">C17</option>
                        <option value="C18">C18</option>
                        <option value="C19">C19</option>
                        <option value="C20">C20</option>
                        <option value="C21">C21</option>
                        <option value="C22">C22</option>
                        <option value="C23">C23</option>
                        <option value="C24">C24</option>
                        <option value="C25">C25</option>
                    </select>
                    <button type="button" onclick="postProblem()">Create</button>
                </td>
            </tr>
		</table>
					<label id="problemlabel" class="active bigFont" for="img_input" onclick="toggleImage(1)">problem</label>
					<label id="answerabel" class="bigFont" for="img_input" onclick="toggleImage(2)">answer</label>
					<label id="problemlabelb" class="bigFont" for="img_input" onclick="toggleImage(3)">problemb</label>
					<label id="problemlabelc" class="bigFont" for="img_input" onclick="toggleImage(4)">problemc</label>
					<br/>
					<br/>
					<br/>
        <#if max != -1>
            <h1 class="bottomArea">
                <#list 0..max as i>
                    <a class="jumper notLinkText sameLine" href="#jump_${problems[i].idproblem?c}">
                        <p class="orange">[${i+1}]</p>
                        <#if problems[i].workmark??>
                            <#if problems[i].workmark == 0>
                                <div class="sameLine right">√</div>
                            <#else>
                                <div class="sameLine wrong">×</div>
                            </#if>
                        </#if>
                    </a>
                </#list>
                <#if after != 0>
                    <a href="./Chapter?chapterid=${after?c}">
                        <p class="sameLine floatRight">→</p>
                    </a>
                </#if>

                <div class="sameLine floatRight">&nbsp;&nbsp;</div>
                <#if before != 0>
                    <a href="./Chapter?chapterid=${before?c}">
                        <p class="sameLine floatRight">←</p>
                    </a>
                </#if>
                <br>
                <p>---------------------------------</p>
            </h1>
        </#if>
	</body>
	<script>
	    var problemDone = ${problemDone};
        var problemNotStart = ${problemNotStart};
        var problemNotPass = ${problemNotPass};
        var problemTotal = ${problemTotal};
        var timeTotal = ${totalTime};

		window.onload = pageLoaded;

		$(window).keypress(function(event) {
            console.log(event);
            if (event.which != 115) return true;
            postProblem();
            event.preventDefault();
            return false;
        });

		function pageLoaded() {
			$('#indexselect option[value='+lastindex+']').next().prop({selected: true});
			$('#moduleselect option[value='+lastmodule+']').prop({selected: true});
			$('#levelselect option[value='+lastlevel+']').prop({selected: true});

			for(var i = 1; i < 10; ++i) {
			    $('#indexselect').append(new Option("0"+i, "0"+i));
			}
			for(var i = 10; i < 99; ++i) {
                $('#indexselect').append(new Option(""+i, ""+i));
            }
		}
		
		function deleteProblem(idproblem) {
			var r=confirm("Are you sure? Delete cannot recover!")
  			if (r==false)
  				return;
  				
			var url = "./Problem?delete="+idproblem;
			
			$.ajax({
			    type: "POST",
			    url: url,
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: "",
				success: function(msg) {
			    	console.log(msg);
			    	window.location.reload()
				},
				error: function(msg) {
			    	console.log(msg);
			    	window.location.reload()
			    }
			})
		}

		function addWhole2Paper(chapterid) {
            var paperid = $( "#paperselect" ).val();
			var url = "./Paper/addchapter2paper?chapterid="+chapterid+"&paperid="+paperid;
			console.log(url);
			$.ajax({
			    type: "POST",
			    url: url,
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: "",
				success: function(msg) {
			    	console.log(msg);
				},
				error: function(msg) {
			    	console.log(msg);
			    }
			})
		}
		
		function activeProblem(idproblem, problemcisactive) {
			var paperid = $( "#paperselect" ).val();
			var url = "./Problem?active="+problemcisactive+"&problemid="+idproblem+"&paperid="+paperid;
			console.log(url);
			$.ajax({
			    type: "POST",
			    url: url,
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: "",
				success: function(msg) {
				    console.log(msg);
			    	alert(JSON.stringify(msg));
				},
				error: function(msg) {
			    	console.log(msg);
			    }
			})
		}
		
		var activeImage=1;
		function deActiveAllImageButton() {
		    $( "#answerabel" ).removeClass("active");
		    $( "#problemlabel" ).removeClass("active");
		    $( "#problemlabelb" ).removeClass("active");
		    $( "#problemlabelc" ).removeClass("active");
		}
		function toggleImage(mode) {
			if (mode==1) {
				activeImage = 1;
				deActiveAllImageButton();
				$( "#problemlabel" ).addClass("active");
			}
			else if (mode==2){
				activeImage = 2;
				deActiveAllImageButton();
				$( "#answerabel" ).addClass("active");
			}
			else if (mode==3){
                activeImage = 3;
                deActiveAllImageButton();
                $( "#problemlabelb" ).addClass("active");
            }
            else if (mode==4){
                activeImage = 4;
                deActiveAllImageButton();
                $( "#problemlabelc" ).addClass("active");
            }
		}
		
		var lastindex='${lastindex}';
		var lastmodule='${lastmodule}';
		var lastlevel='${lastlevel}';
		var imgProblemString;
		var imgAnswerString;
		var imgProblemStringb;
		var imgProblemStringc;
		var chapterid = ${chapterid};
		function postProblem() {
			var pData = {};
			pData.problemlevel = $( "#levelselect" ).val();
			pData.problemdetail = imgProblemString.substr(22);
			if (imgProblemStringb != undefined)
			    pData.problemdetailb = imgProblemStringb.substr(22);
			if (imgProblemStringc != undefined)
			    pData.problemdetailc = imgProblemStringc.substr(22);
			pData.problemanswerdetail = imgAnswerString.substr(22);
			pData.problemchapterid = chapterid;
			pData.problemindex=$( "#indexselect" ).val();
			pData.problemmodule=$( "#moduleselect" ).val();
			pData.problemanswerstring=$( "#answerstring" ).val();
			
			//console.log(JSON.stringify(pData));
			console.log('==========');
			$.ajax({
			    type: "POST", // 上传文件要用POST
			    url: "./Problem/new",
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: JSON.stringify(pData),
				success: function(msg) {
					console.log('sssssssssssave problem');
			    	console.log(msg);
			    	window.location.reload();
			    	window.scrollTo(0,10000);
				},
				error: function(msg) {
			    	console.log(msg);
			    	window.location.reload()
			    	window.scrollTo(0,10000);
			    }
			})
		}
		
		$("#img_input").on("change", function(e){
		
		  var file = e.target.files[0]; //获取图片资源
		
		  if (!file.type.match('image.*')) {
		    return false;
		  }
		
		  var reader = new FileReader();
		
		  reader.readAsDataURL(file); // 读取文件
		
		  // 渲染文件
		  reader.onload = function(arg) {
		
			if (activeImage == 1) {
				imgProblemString = arg.target.result;
		    	var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
		    	//console.log(img);
		    	$("#problemview").empty().append(img);
		    	console.log('dddddddddddddddddd');
		    	toggleImage(2);
		    	
		    	window.scrollTo(0,10000);
		    }
		    else if (activeImage == 2){
		    	imgAnswerString = arg.target.result;
		    	var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
		    	//console.log(img);
		    	$("#answerview").empty().append(img);
		    }
		    else if (activeImage == 3){
                imgProblemStringb = arg.target.result;
                var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
                //console.log(img);
                console.log('33333333');
                $("#problemviewb").empty().append(img);
            }
            else if (activeImage == 4){
                imgProblemStringc = arg.target.result;
                var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
                //console.log(img);
                $("#problemviewc").empty().append(img);
            }
		  }
		});
		
		(function($) {
		  var defaults;
		  $.event.fix = (function(originalFix) {
		    return function(event) {
		      event = originalFix.apply(this, arguments);
		      if (event.type.indexOf('copy') === 0 || event.type.indexOf('paste') === 0) {
		        event.clipboardData = event.originalEvent.clipboardData;
		      }
		      return event;
		    };
		  })($.event.fix);
		  defaults = {
		    callback: $.noop,
		    matchType: /image.*/
		  };
		  return $.fn.pasteImageReader = function(options) {
		    if (typeof options === "function") {
		      options = {
		        callback: options
		      };
		    }
		    options = $.extend({}, defaults, options);
		    return this.each(function() {
		      var $this, element;
		      element = this;
		      $this = $(this);
		      return $this.bind('paste', function(event) {
		        var clipboardData, found;
		        found = false;
		        clipboardData = event.clipboardData;
		        return Array.prototype.forEach.call(clipboardData.types, function(type, i) {
		          var file, reader;
		          if (found) {
		            return;
		          }
		          if (type.match(options.matchType) || clipboardData.items[i].type.match(options.matchType)) {
		            file = clipboardData.items[i].getAsFile();
		            reader = new FileReader();
		            reader.onload = function(evt) {
		              return options.callback.call(element, {
		                dataURL: evt.target.result,
		                event: evt,
		                file: file,
		                name: file.name
		              });
		            };
		            reader.readAsDataURL(file);
		            reader.onload = function(arg) {
		            
		            	if (activeImage == 1) {
							imgProblemString = arg.target.result;
					    	var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
					    	
					    	$("#problemview").empty().append(img);
					    	window.scrollTo(0,1000000);
					    	toggleImage(2);
					    }
					    else if (activeImage == 2){
					    	imgAnswerString = arg.target.result;
					    	var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
					    	//console.log(img);
					    	console.log('--------------------');
					    	$("#answerview").empty().append(img);
					    	window.scrollTo(0,1000000);
					    	toggleImage(3);
					    }
					    else if (activeImage == 3){
                            imgProblemStringb = arg.target.result;
                            var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
                            //console.log(img);
                            console.log('33333333');
                            $("#problemviewb").empty().append(img);
                            toggleImage(4);
                        }
                        else if (activeImage == 4){
                            imgProblemStringc = arg.target.result;
                            var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
                            //console.log(img);
                            $("#problemviewc").empty().append(img);
                        }
		

					  }
		            return found = true;
		          }
		        });
		      });
		    });
		  };
		})(jQuery);
		
		
		
		$("html").pasteImageReader(function(results) {
		  var dataURL, filename;
		  filename = results.filename, dataURL = results.dataURL;
		  $data.text(dataURL);
		  $size.val(results.file.size);
		  $type.val(results.file.type);
		  $test.attr('href', dataURL);
		  var img = document.createElement('img');
		  img.src= dataURL;
		  var w = img.width;
		  var h = img.height;
		  $width.val(w)
		  $height.val(h);
		  return $(".active").css({
		    backgroundImage: "url(" + dataURL + ")"
		  }).data({'width':w, 'height':h});
		});
		
		var $data, $size, $type, $test, $width, $height;
		$(function() {
		  $data = $('.data');
		  $size = $('.size');
		  $type = $('.type');
		  $test = $('#test');
		  $width = $('#width');
		  $height = $('#height');
		  $('.target').on('click', function() {
		    var $this = $(this);
		    var bi = $this.css('background-image');
		    if (bi!='none') {
		        $data.text(bi.substr(4,bi.length-6));
		    }
		                    
		                    
		    $('.active').removeClass('active');
		    $this.addClass('active');
		    
		    $this.toggleClass('contain');
		    
		    $width.val($this.data('width'));
		    $height.val($this.data('height'));
		    if ($this.hasClass('contain')) {
		      $this.css({'width':$this.data('width'), 'height':$this.data('height'), 'z-index':'10'})
		    } else {
		      $this.css({'width':'', 'height':'', 'z-index':''})
		    }
		    
		  })
		})
		
		
		function copy(text) {
	      var t = document.getElementById('base64')
	      t.select()
	      try {
	        var successful = document.execCommand('copy')
	        var msg = successful ? 'successfully' : 'unsuccessfully'
	        alert('Base64 data coppied ' + msg+' to clipboard')
	      } catch (err) {
	        alert('Unable to copy text')
	      }
	    }

	    <#if after != 0>
        $(document).keypress(function(e) {
            if (e.keyCode == 13) {
                window.location.href = "./Chapter?chapterid=${after?c}"
            }
        });
        </#if>
        <#if before != 0>
        $(document).keypress(function(e) {
            if (e.keyCode == 48) {
                window.location.href = "./Chapter?chapterid=${before?c}"
            }
        });
        </#if>
	</script>
</html>