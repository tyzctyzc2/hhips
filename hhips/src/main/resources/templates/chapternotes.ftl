<html>
<head>
	<meta charset="utf-8"/>
	<title>笔记 - ${chaptername}</title>
	<script type="text/javascript" src="./jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="./js/common.js"></script>
	<link href="./css/myStyle.css" rel="stylesheet" type="text/css" media="all">
</head>
	<body>
		<#include "/header.ftl">
		<table class="boldFont">
            <tr>
                <td>
                    <#if before != 0>
                        <div><a href="./note?chapterid=${before?c}" style="text-decoration: none">前一章</a></div>
                    </#if></td>
                <td>
                    <#if after != 0>
                        <div><a href="./note?chapterid=${after?c}" style="text-decoration: none">&nbsp;&nbsp;&nbsp;&nbsp;后一章</a></div>
                    </#if>
                </td>
            </tr>
        </table>
		<#include "/chapterheader.ftl">
		<table>
		<#list notes as n>
		    <tr>
                <td>
                    <div>${n.chapternotetime}</div>
                </td>
            </tr>
		    <tr>
		        <td>
		            <img id="myImage" class="center-fit" src=.\${n.chapternotedetail} />
                </td>
		    </tr>
		</#list>
		</table>
		<input type="file" multiple="multiple" :name="uploadFieldName" @change="filesChange($event.target.files); "
                      accept="any/*" class="input-file">
		<button class="largeFont" type="button" onclick="postPDF()">上传PDF文件</button>
		<button class="largeFont" type="button" onclick="postNote()">提交当前图</button>
		<div class="preview_box" id="newNoteView"></div>
	</body>
	<script>
	    var idsourcechapter = ${chapterid}
	    var imgProblemString;
	    function postNote() {
	        if (imgProblemString == undefined) {
	            return;
	        }
            var pData = {};
            pData.chapternotedetail = imgProblemString.substr(22);
            pData.idsourcechapter = idsourcechapter;

            console.log(JSON.stringify(pData));
            console.log('==========');
            $.ajax({
            type: "POST",
            url: "./note/new",
            dataType : "json",
            contentType: "application/json",
            data: JSON.stringify(pData),
            success: function(msg) {
                console.log('sssssssssssave note');
                console.log(msg);
                window.location.reload();
            },
            error: function(msg) {
                //console.log(msg);
                window.location.reload()
            }
            })
        }

        function postPDF() {

        }

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
                                    imgProblemString = arg.target.result;
                                    var img = '<img class="preview" src="' + arg.target.result + '" alt="preview"/>';
                                    $("#newNoteView").empty().append(img);
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
    </script>
</html>