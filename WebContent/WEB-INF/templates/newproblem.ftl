<html>
	<head>
		<meta charset="utf-8"/>
		<title>New Problem</title>
		<style>
			.preview_box img {
				width: 400px;
			}
			.active {
				box-shadow: 0px 0px 10px 10px rgba(0,0,255,.4);
			}
		</style>
		<script type="text/javascript" src="/hhipsair/jquery-3.3.1.min.js"></script>
	</head>
	
	<body>
		<h1>New Problem</h1>
		<p>${chapername}</p>

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
						<option value="L2">L2</option>
						<option value="L2L">L2L</option>
						<option value="L3">L3</option>
						<option value="L4">L4</option>
						<option value="L4L">L4L</option>
						<option value="L5">L5</option>
						<option value="L5L">L5L</option>
						<option value="L6">L6</option>
						<option value="L7">L7</option>
						<option value="L8">L8</option>
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
			
			console.log(JSON.stringify(pData));
			$.ajax({
			    type: "POST", // 上传文件要用POST
			    url: "/hhipsair/Problem",
			    dataType : "json",
				processData: false,  // 注意：不要 process data
				contentType: false,  // 注意：不设置 contentType
			    data: JSON.stringify(pData),
				success: function(msg) {
			    	console.log(msg);
				},
				fail: function(msg) {
			    	console.log(msg);
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