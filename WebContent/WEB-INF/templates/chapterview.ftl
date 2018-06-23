<html>
<head>
	<meta charset="utf-8"/>
	<title>Chapter View</title>
	<script type="text/javascript" src="/hhipsair/jquery-3.3.1.min.js"></script>
	<style>
		* {
			margin: 0;
			padding: 0;
		}
		.imgbox {
			display: grid;
			height: 100%;
		}
		.center-fit {
			max-width: 100%;
			max-height: 100vh;
			margin: auto;
		}
		.edge {
			box-shadow: 0px 0px 2px 2px rgba(0,0,255,.4);
		}
		.activeButton {
			background-color: darkkhaki;
			height:100px;
			width:60px;
		}
		.normalButton {
			height:100px;
			width:60px;
		}
		.preview_box img {
			width: 400px;
		}
		.active {
			box-shadow: 0px 0px 10px 10px rgba(0,0,255,.4);
		}
		.right {
			color:green;
		}
		.wrong {
			color:red;
		}
	</style>
</head>
	<body>
		<h1>${chapername}</h1>
		<#if maxpaper != -1>
			<select id="paperselect">
				<#list 0..maxpaper as i>
					<option value=${papers[i].idpaper}>${papers[i].papername}</option>
				</#list>
			</select>
		</#if>
		<#if max != -1>
			<#list 0..max as i>
				<table>
						<tr class="edge">
							<td>
								<p>${problems[i].problemindex}</p>
							</td>
							<td>
								<p>${problems[i].modulename}</p>
							</td>
							<td>
								<button type="button" class="normalButton" onclick="deleteProblem(${problems[i].idproblem})">Delete</button>
							</td>
							<td>
								<p>${problems[i].problemlevel}</p>
							</td>
							<td>
								<#if problems[i].problemcisactive != 0>
									<button type="button" id=active_${problems[i].idproblem}" class="activeButton" onclick="activeProblem(${problems[i].idproblem}, 0)">Deactive</button>
								<#else>
									<button type="button" id=active_${problems[i].idproblem}" class="normalButton" onclick="activeProblem(${problems[i].idproblem}, 5)">Active</button>
								</#if>
							</td>
							<td>
								<a href="/hhipsair/Problem?problemid=${problems[i].idproblem}">    
								<img id="myImage" class="center-fit" src=${problems[i].problemdetail} />
								</a>
							</td>
						</tr>	
				</table>
				<table>					
						<tr>
							<td>
								<#if problems[i].idwork??>
									<p>${problems[i].workdate?string("yyyy-MM-dd")} --- ${problems[i].usedtime}</p>
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
								<img id="answer" class="center-fit" src=${problems[i].problemanswerdetail} />
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
						<option value="L1L">L1L</option>
						<option value="L2">L2</option>
						<option value="L2L">L2L</option>
						<option value="L3">L3</option>
						<option value="L3L">L3L</option>
						<option value="L4">L4</option>
						<option value="L4L">L4L</option>
						<option value="L5">L5</option>
						<option value="L5L">L5L</option>
						<option value="L6">L6</option>
						<option value="L6L">L6L</option>
						<option value="L7">L7</option>
						<option value="L7L">L7L</option>
						<option value="L8">L8</option>
						<option value="L8L">L8L</option>
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
						<option value="24">24</option>
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
						<option value="J01">J01</option>
						<option value="J02">J02</option>
						<option value="J03">J03</option>
						<option value="J04">J04</option>
						<option value="J05">J05</option>
					</select>
					<button type="button" onclick="postProblem()">Create</button>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" id="answerstring" />
				</td>
			</tr>
			<tr>
				<td>
					<textarea id="base64" cols="30" rows="10" class="data span12"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<label id="problemlabel" class="active" for="img_input" onclick="toggleImage(1)">problem</label>
					<label id="answerabel" for="img_input" onclick="toggleImage(2)">answer</label>
					<div class="preview_box" id="problemview"></div>
					<div class="preview_box" id="answerview"></div>
				</td>
			</tr>
		</table>
	</body>
	<script>
		window.onload = pageLoaded;
		function pageLoaded() {
			$('#indexselect option[value='+lastindex+']').next().prop({selected: true});
			$('#moduleselect option[value='+lastmodule+']').prop({selected: true});
			$('#levelselect option[value='+lastlevel+']').prop({selected: true});
		}
		
		function deleteProblem(idproblem) {
			var r=confirm("Are you sure? Delete cannot recover!")
  			if (r==false)
  				return;
  				
			var url = "/hhipsair/Problem?delete="+idproblem;
			
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
		
		function activeProblem(idproblem, problemcisactive) {
			var paperid = $( "#paperselect" ).val();
			var url = "/hhipsair/Problem?active="+problemcisactive+"&problemid="+idproblem+"&paperid="+paperid;
			
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
		
		var activeImage=1;
		function toggleImage(mode) {
			if (mode==1) {
				activeImage = 1;
				$( "#problemlabel" ).addClass("active");
				$( "#answerabel" ).removeClass("active");
			}
			else {
				activeImage = 2;
				$( "#answerabel" ).addClass("active");
				$( "#problemlabel" ).removeClass("active");
			}
		}
		
		var lastindex='${lastindex}';
		var lastmodule='${lastmodule}';
		var lastlevel='${lastlevel}';
		var imgProblemString;
		var imgAnswerString;
		var chaperid = ${chaperid};
		function postProblem() {
			var pData = {};
			pData.problemlevel = $( "#levelselect" ).val();
			pData.problemdetail = imgProblemString.substr(22);
			pData.problemanswerdetail = imgAnswerString.substr(22);
			pData.problemchapterid = chaperid;
			pData.problemindex=$( "#indexselect" ).val();
			pData.problemmodule=$( "#moduleselect" ).val();
			pData.problemanswerstring=$( "#answerstring" ).val();
			
			//console.log(JSON.stringify(pData));
			console.log('==========');
			$.ajax({
			    type: "POST", // 上传文件要用POST
			    url: "/hhipsair/Problem",
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: JSON.stringify(pData),
				success: function(msg) {
					console.log('sssssssssssave problem');
			    	console.log(msg);
			    	window.location.reload();
				},
				error: function(msg) {
			    	console.log(msg);
			    	window.location.reload()
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
		    }
		    else {
		    	imgAnswerString = arg.target.result;
		    	var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
		    	//console.log(img);
		    	$("#answerview").empty().append(img);
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
					    	//console.log(img);
					    	$("#problemview").empty().append(img);
					    }
					    else {
					    	imgAnswerString = arg.target.result;
					    	var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
					    	//console.log(img);
					    	$("#answerview").empty().append(img);
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
	</script>
</html>