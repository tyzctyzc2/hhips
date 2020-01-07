<html>
<head>
	<meta charset="utf-8"/>
	<title>${sourceName}-${chapterIndex}-${chapterName}-${problemdetail.problemindex}</title>
	<link href="./jqueryui/jquery-ui.css" rel="stylesheet" type="text/css" media="all">
	<link href="./default/style.min.css" rel="stylesheet" type="text/css" media="all">
    <link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
    <script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="./jstree.min.js"></script>
    <script type="text/javascript" src="./jqueryui/jquery-ui.js"></script>
    <script type="text/javascript" src="./js/common.js"></script>
</head>
	<body>
	    <#include "/header.ftl">
	    <table class="boldFont">
	        <tr>
	            <td>
	                <#if before != 0>
                        <div><a href="./Problem?problemid=${before?c}" style="text-decoration: none">前一题</a></div>
                    </#if></td>
                <td>
                    <#if after != 0>
                        <div><a href="./Problem?problemid=${after?c}" style="text-decoration: none">&nbsp;&nbsp;&nbsp;&nbsp;后一题</a></div>
                    </#if>
                </td>
	        </tr>
	    </table>
	    <table class="bigFont boldFont">
            <tr>
                <td>
                    <div class="bigFont"><a href="./Chapter?sourceid=${sourceId}" style="text-decoration: none">${sourceName}--></a></div>
                </td>
                <td>
                    <div class="bigFont"><a href="./Chapter?chapterid=${problemdetail.problemchapterid}" style="text-decoration: none">&nbsp;&nbsp;${chapterIndex} - ${chapterName}</a></div>
                </td>
                <td>
                    <#if problemdetail.problemlevel == 1>
                        <div>-->    ${problemdetail.problemindex} (☆)</div>
                    </#if>
                    <#if problemdetail.problemlevel == 2>
                        <div>-->    ${problemdetail.problemindex} (☆☆)</div>
                    </#if>
                    <#if problemdetail.problemlevel == 3>
                        <div>-->    ${problemdetail.problemindex} (☆☆☆)</div>
                    </#if>
                    <#if problemdetail.problemlevel == 4>
                        <div>-->    ${problemdetail.problemindex} (☆☆☆☆)</div>
                    </#if>
                </td>
            </tr>
        </table>


        <#list inActivePaper as paper>
            <p>${paper.papername}</p>
        </#list>
        <table style="font-size:  x-large;">
            <tr>
            <#list myTags as tag>
                <td class="edgeRound">
                    <a href="./tag?tagid=${tag.idtag}" style="text-decoration: none">${tag.tagname}</a>
                </td>
            </#list>
            <td>
                <button class="bigFont" type="button" onclick="showTag()">Change Tag</button>
            </td>
            <td>
                <#if maxpaper != -1>
                    <select id="paperselect">
                        <#list 0..maxpaper as i>
                            <option value=${papers[i].idpaper?c}>${papers[i].papername}</option>
                        </#list>
                    </select>
                </#if>
            </td>
            <td>
                <button class="bigFont" type="button" onclick="add2Paper(${problemdetail.idproblem?c},5)">Add to Paper</button>
            </td>
            </tr>
        </table>
        <div id="dialog" title="Tag dialog" class="hide">
            <div id="container">
                <ul>
                    <li>Root node
                        <ul>
                            <li>dej
                                <ul>
                                    <li>Child node 1</li>
                                </ul>
                            </li>
                            <li>Child node 2</li>
                        </ul>
                    </li>
                </ul>
                <br>
            </div>
            <table style="font-size:  x-large;">
                <#list allTags as rowtag>
                    <tr>
                    <#list rowtag as tag>
                        <td class="edgeRound picked">
                            <div onclick="changeTag(${problemdetail.idproblem?c}, ${tag.idtag})">${tag.tagname}</div>
                        </td>
                    </#list>
                    </tr>
                </#list>
            </table>
            <table style="font-size:  x-large;">
                <tr>
                    <td>
                        <input class="bigFont" type="text" id="newTagName" />
                        <button class="bigFont" type="button" onclick="postTag()">+New Tag</button>
                    </td>
                </tr>
            </table>
        </div>
		<table>
			<tr class="edge">
				<td>
					<img id="myImage" class="center-fit" src=.\${problemdetail.problemdetail} />
				</td>
			</tr>	
		</table>
		<table>
			<tr class="edge">
				<td>
					<img id="myImage" class="center-fit" src=.\${problemdetail.problemanswerdetail} />
				</td>
			</tr>	
		</table>
		<#if worklength != -1>
			<table>
					<#list 0..worklength as i>
						<tr class="edge">
							<td class="edge">
								<p>${works[i].workdate?string("yyyyMMdd")}</p>
								<button type="button" onclick=rotateWork("${works[i].workdetail}")>Rotate</button>
							</td>
							<td class="edge">
                                <p>${works[i].usedtime?c}</p>
                            </td>
							<#if works[i].workmark??>
                                <#if works[i].workmark == 0>
                                    <td class="edge"><p class="right">通过</p></td>
                                <#else>
                                    <td class="edge"><p class="wrong">未过</p></td>
                                </#if>
                            <#else>
                                <td class="edge"><p class="orange">待批</p></td>
                            </#if>
                            <#if works[i].idstarreason??>
                                <td class="edge"><p class="right">🌟${works[i].starreasonname}</p></td>
                            <#else>
                                <td class="edge"> </td>
                            </#if>
                            <#if works[i].reasonname??>
                                <td class="edge"><p class="wrong">🌟${works[i].reasonname}</p></td>
                            <#else>
                                <td class="edge"> </td>
                            </#if>
							<td class="edge">
							    <#if works[i].workdetail?contains('t')>
							        <img id="myImage" class="center-fit_small" src=.\${works[i].workdetail} />
                                <#else>
                                    <img id="myImage" class="center-fit imgFullPage" src=.\${works[i].workdetail} />
							    </#if>

							</td>
						</tr>
					</#list>
			</table>
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
                        <option value="L2">L2</option>
                        <option value="L3">L3</option>
                        <option value="L4">L4</option>
                        <option value="L5">L5</option>
                        <option value="L6">L6</option>
                        <option value="L7">L7</option>
                        <option value="L8">L8</option>
                        <option value="L9">L9</option>
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
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                        <option value="32">32</option>
                        <option value="33">33</option>
                        <option value="34">34</option>
                        <option value="35">35</option>
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
                        <option value="J06">J06</option>
                        <option value="J07">J07</option>
                        <option value="J08">J08</option>
                        <option value="J09">J09</option>
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
                        <option value="C01">C01</option>
                        <option value="C02">C02</option>
                        <option value="C03">C03</option>
                        <option value="C04">C04</option>
                        <option value="C05">C05</option>
                        <option value="C06">C06</option>
                        <option value="C07">C07</option>
                        <option value="C08">C08</option>
                        <option value="C09">C09</option>
                        <option value="C10">C10</option>
                        <option value="X01">X01</option>
                        <option value="X02">X02</option>
                        <option value="X03">X03</option>
                        <option value="X04">X04</option>
                        <option value="X05">X05</option>
                        <option value="X06">X06</option>
                        <option value="X07">X07</option>
                        <option value="X08">X08</option>
                        <option value="X09">X09</option>
                        <option value="X10">X10</option>
                    </select>
                    <button type="button" onclick="postProblem()">Update</button>
                </td>
            </tr>
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
                    <div class="preview_box" id="answerview"></div>
                </td>
            </tr>
        </table>
        <label id="problemlabel" class="active bigFont" for="img_input" onclick="toggleImage(1)">problem</label>
        <label id="answerabel" class="bigFont" for="img_input" onclick="toggleImage(2)">answer</label>
        <br/>
        <br/>
        <br/>
	</body>
	<script>
        window.onload = pageLoaded;
        $("#container").jstree({
            "core":{
                "data":{
                    "url": "./childtag?rootid=1",
                    "dataType": "json"
                }
            }
        })
        .on('loaded.jstree', function() {
            $("#container").jstree('open_all');
        });
        $("#container").on(
            "select_node.jstree", function(evt, data){
                console.log(data.node.id);
                changeTag(${problemdetail.idproblem?c}, data.node.id)
                //window.open('./tag?tagid='+data.node.id);
            }
        );
        $(window).keypress(function(event) {
            console.log(event);
            if (event.which != 115) return true;
            postProblem();
            event.preventDefault();
            return false;
        });
        function pageLoaded() {
            $('#indexselect option[value='+lastindex+']').prop({selected: true});
            $('#moduleselect option[value='+lastmodule+']').prop({selected: true});
            $('#levelselect option[value='+lastlevel+']').prop({selected: true});
        }

        function showTag() {
            $( "#dialog" ).dialog({
                    modal: true,
                  width: 800,
                  height: 600});
        }

        function rotateWork(filename) {
            console.log(filename)
            filename = filename.replace("\\", "_")
            console.log(filename)
            var url = "./image/rotate?imagename="+filename
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
                        alert("完成，Ctrl+F5更新")
                    },
                    error: function(msg) {
                        console.log(msg);
                    }
                })
        }

        function add2Paper(idproblem, problemcisactive) {
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

        function changeTag(problemID, tagID) {
            $('#dialog').dialog('close')
            var pData = {};
            pData.idproblem = problemID;
            pData.idtag = tagID;

            console.log(JSON.stringify(pData));
            console.log('==========');
            $.ajax({
                type: "POST", // 上传文件要用POST
                url: "./tag/update",
                dataType : "json",
                processData: false,  // 注意：不要 process data
                contentType: false,  // 注意：不设置 contentType
                data: JSON.stringify(pData),
                success: function(msg) {
                    console.log('tag changed');
                    console.log(msg);
                    window.location.reload();
                },
                error: function(msg) {
                    console.log(msg);
                    window.location.reload()
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
        var idproblem = ${problemdetail.idproblem?c}
        var imgProblemString = '';
        var imgAnswerString = '';

        function postProblem() {
            var pData = {};
            pData.problemlevel = $( "#levelselect" ).val();
            pData.problemdetail = imgProblemString.substr(22);
            pData.problemanswerdetail = imgAnswerString.substr(22);
            pData.problemchapterid = ${problemdetail.problemchapterid};
            pData.problemindex=$( "#indexselect" ).val();
            pData.problemmodule=$( "#moduleselect" ).val();
            pData.problemanswerstring=$( "#answerstring" ).val();
            pData.idproblem = idproblem;

            console.log(JSON.stringify(pData));
            console.log('==========');
            $.ajax({
                type: "POST", // 上传文件要用POST
                url: "./Problem/update",
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

                            $("#problemview").empty().append(img);
                            window.scrollTo(0,1000000);
                            toggleImage(2);
                        }
                        else {
                            imgAnswerString = arg.target.result;
                            var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
                            //console.log(img);

                            $("#answerview").empty().append(img);
                            window.scrollTo(0,1000000);
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
                window.location.href = "./Problem?problemid=${after?c}"
            }
        });
        </#if>
        <#if before != 0>
        $(document).keypress(function(e) {
            if (e.keyCode == 48) {
                window.location.href = "./Problem?problemid=${before?c}"
            }
        });
        </#if>
    </script>
</html>