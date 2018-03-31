/**
 * Frontwise grid editor plugin.
 */
(function( $ ){

    $.fn.gridEditor = function( options ) {

        var self = this;
        var grideditor = self.data('grideditor');

        /** Methods **/

        if (arguments[0] == 'getHtml') {
            getDataHmtl();
        }

        function getDataHmtl() {
            if (grideditor) {
                grideditor.deinit();
                var html = self.html();
                grideditor.init();
                return html;
            } else {
                return self.html();
            }
        }

        /** Initialize plugin */

        self.each(function(baseIndex, baseElem) {
            baseElem = $(baseElem);

            var settings = $.extend({
                'new_row_layouts'   : [ // Column layouts for add row buttons
                    [12],
                    [6, 6],
                    [4, 4, 4],
                    [3, 3, 3, 3],
                    [4, 8],
                    [8, 4]
                ],
                'row_classes'       : [{ label: 'Example class', cssClass: 'example-class'}],
                'col_classes'       : [{ label: 'Example class', cssClass: 'example-class'}],
                'col_tools'         : [], /* Example:
                                        [ {
                                            title: 'Set background image',
                                            iconClass: 'glyphicon-picture',
                                            on: { click: function() {} }
                                        } ]
                                    */
                'row_tools'         : [],
                'row_setting'       : [{
                                            label: 'Background image',
                                            type: 'text',
                                            id: 'backgroud-image',
                                            iconClass: 'glyphicon-picture',
                                            on: {
                                                click: function() {
                                                    alert();
                                                }
                                            }
                                     },
                                    {
                                        label: 'Padding',
                                        type: 'text',
                                        id: 'padding',
                                        iconClass: 'glyphicon-picture',
                                    }
                                    ],
                'custom_filter'     : '',
                'content_types'     : ['tinymce'],
                'valid_col_sizes'   : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                'source_textarea'   : ''
            }, options);


            // Elems
            var canvas,
                mainControls,
                addRowGroup,
                htmlTextArea
            ;
            var colClasses = ['col-md-', 'col-sm-'];
            var curColClassIndex = 0; // Index of the column class we are manipulating currently
            var MAX_COL_SIZE = 12;

            // Copy html to sourceElement if a source textarea is given
            if (settings.source_textarea) {
                var sourceEl = $(settings.source_textarea);

                sourceEl.addClass('ge-html-output');
                htmlTextArea = sourceEl;

                if (sourceEl.val()) {
                    baseElem.html(sourceEl.val());
                }
            }

            // Wrap content if it is non-bootstrap
            if (baseElem.children().length && !baseElem.find('div.row').length) {
                var children = baseElem.children();
                var newRow = $('<div class="row"><div class="col-md-12"/></div>').appendTo(baseElem);
                newRow.find('.col-md-12').append(children);
            }
            if(!grideditor) {
                setup();
                init();
                self.bind("DOMSubtreeModified",function(){
                    setTimeout(function () {
                        updateData();
                    },300);
                });
            }
            function updateData() {
                var getDataHmtlClone =$(getDataHmtl()).clone(true);
                var getDataHmtls = $("<div>");
                getDataHmtlClone.appendTo(getDataHmtls);
                getDataHmtls.removeClass('ge-editing');
                var contents = getDataHmtls.find('.ge-content').each(function() {
                    var content = $(this);
                    content.filter('.active').each(function() {
                        var contentArea = $(this);
                        contentArea
                            .removeClass('active')
                            .removeClass('mce-content-body')
                            .removeClass('mce-edit-focus')
                            .removeAttr('id')
                            .removeAttr('style')
                            .removeAttr('spellcheck')
                            .removeAttr('contenteditable');
                        contentArea.next().remove();
                    });
                });

                var contents = getDataHmtls.find('.ge-content').each(function() {
                    var content = $(this);
                    content.filter('.active').each(function() {
                        var contentArea = $(this);
                        contentArea
                            .removeClass('active')
                            .removeClass('mce-content-body')
                            .removeClass('mce-edit-focus')
                            .removeAttr('id')
                            .removeAttr('style')
                            .removeAttr('spellcheck')
                            .removeAttr('contenteditable');
                        contentArea.next().remove();
                    });
                });
                getDataHmtls.find('.ge-tools-drawer').remove();
                htmlTextArea.val(getDataHmtls.html());
            }

            function setup() {
                /* Setup canvas */
                canvas = baseElem.addClass('ge-canvas');
                /*Nếu không có textarea được chọn */
                if (typeof htmlTextArea === 'undefined' || !htmlTextArea.length) {
                    htmlTextArea = $('<textarea class="ge-html-output"/>').insertBefore(canvas);
                }

                /* Create main controls*/
                mainControls = $('<div class="ge-mainControls" />').insertBefore(canvas);
                var wrapper = $('<div class="ge-wrapper ge-top" />').appendTo(mainControls);

                // Add row
                addRowGroup = $('<div class="ge-addRowGroup btn-group" />').appendTo(wrapper);
                $.each(settings.new_row_layouts, function(j, layout) {
                    var btn = $('<a class="btn btn-xs btn-primary" />')
                        .attr('title', 'Add row ' + layout.join('-'))
                        .on('click', function() {
                            var row = createRow().appendTo(canvas);
                            layout.forEach(function(i) {
                                createColumn(i).appendTo(row);
                            });
                            init();
                        })
                        .appendTo(addRowGroup);
                    var layoutName = layout.join(' - ');
                    var icon = '<div class="row ge-row-icon">';
                    layout.forEach(function(i) {
                        icon += '<div class="column col-xs-' + i + '"/>';
                    });
                    icon += '</div>';
                    btn.append(icon);
                });
                var template =$('<a style="margin-left: 5px;" class="btn btn-info">')
                    .attr('title', 'Mẫu có sẵn')
                    .on('click', function() {
                        var data_modal ={};
                        data_modal.title="Mẫu sẵn có";
                        data_modal.saveText="Thêm vào";
                        data_modal.size="modal-lg";
                        var list_image = [
                            'http://innovastudio.com/builderdemo/assets/minimalist-basic/thumbnails/g02.png',
                            'http://innovastudio.com/builderdemo/assets/minimalist-basic/thumbnails/e09.png',
                            'http://innovastudio.com/builderdemo/assets/minimalist-basic/thumbnails/g03.png',
                            'http://innovastudio.com/builderdemo/assets/minimalist-basic/thumbnails/g03.png',
                            'http://innovastudio.com/builderdemo/assets/minimalist-basic/thumbnails/b12.png',
                            'http://innovastudio.com/builderdemo/assets/minimalist-basic/thumbnails/g03.png',
                            'http://innovastudio.com/builderdemo/assets/minimalist-basic/thumbnails/g03.png',
                            'http://innovastudio.com/builderdemo/assets/minimalist-basic/thumbnails/w04.png',
                            'http://innovastudio.com/builderdemo/assets/minimalist-basic/thumbnails/r04.png'
                        ];
                        var html_template =$('<div/>');
                        var img_html ="";
                        $.each(list_image,function (index,item) {
                            $('<div class="col-md-4 text-center" style="margin-bottom: 10px;"><div class="image-template"><img class="img-responsive" src="'+item+'" />').appendTo(html_template);
                        });
                        data_modal.body=$('<div class="row"/>').append(html_template.html()).get(0).outerHTML;
                        bootstrap().modal.init(data_modal);
                        $("#"+bootstrap().modal.name_modal).modal('show');
                    });
                    template.append("<span><i class='fa fa-newspaper-o'></i> Mẫu</span>").appendTo(wrapper);
                // Buttons on right
                var layoutDropdown = $('<div class="dropdown pull-right ge-layout-mode">' +
                    '<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span><i class="fa fa-desktop"></i> Desktop</span></button>' +
                    '<ul class="dropdown-menu" role="menu">' +
                    '<li><a data-width="auto" title="Desktop"><span><i class="fa fa-desktop"></i> Desktop</span></a></li>' +
                    '<li><a title="Tablet"><span><i class="fa fa-tablet"></i> Tablet</span></li>' +
                    '<li><a title="Phone"><span><i class="fa fa-mobile"></i> Phone</span></a></li>' +
                    '</ul>' +
                    '</div>')
                    .on('click', 'a', function() {
                        var a = $(this);
                        switchLayout(a.closest('li').index());
                        var btn = layoutDropdown.find('button');
                        btn.find('span').remove();
                        btn.append(a.find('span').clone());

                        canvas.empty().html(htmlTextArea.val()).show();
                        init();
                        tinyMCE.execCommand("mceRemoveEditor", true, settings.option_tinymce.selector.replace("#",''));
                        htmlTextArea.hide();
                        canvas.removeClass('ge-editing');
                    })
                    .appendTo(wrapper)
                ;
                var btnGroup = $('<div class="btn-group pull-right"/>')
                    .appendTo(wrapper)
                ;
                var htmlButton = $('<button title="Mode visual builder" type="button" class="btn btn-primary gm-edit-mode"><i class="fa fa-magic"></i> Kéo thả</button>')
                    .on('click', function() {
                        canvas.empty().html(htmlTextArea.val()).show();
                        init();
                        tinyMCE.execCommand("mceRemoveEditor", true, settings.option_tinymce.selector.replace("#",''));
                        htmlTextArea.hide();
                        canvas.addClass('ge-editing');
                    })
                    .appendTo(btnGroup)
                ;
                var htmlButton = $('<button title="Mode editor" type="button" class="btn btn-primary gm-edit-mode"><i class="fa fa-file-code-o"></i> Văn bản</button>')
                    .on('click', function() {
                        deinit();
                        htmlTextArea
                            .height(0.8 * $(window).height())
                            .val(canvas.html())
                            .show()
                        ;
                        if(typeof $(settings.option_tinymce.selector).data("editor") =="undefined") {
                            tinymce.init(settings.option_tinymce);
                            $(settings.option_tinymce.selector).data("editor",true);
                        }else{
                            tinyMCE.execCommand("mceAddEditor", true, settings.option_tinymce.selector.replace("#",''));
                        }
                        canvas.hide();
                        canvas.addClass('ge-editing');
                    }).appendTo(btnGroup);

                // Make controls fixed on scroll
                var $window = $(window);
                $window.on('scroll', function(e) {
                    if (
                        $window.scrollTop() > mainControls.offset().top &&
                        $window.scrollTop() < canvas.offset().top + canvas.height()
                    ) {
                        if (wrapper.hasClass('ge-top')) {
                            wrapper
                                .css({
                                    left: wrapper.offset().left,
                                    width: wrapper.outerWidth(),
                                })
                                .removeClass('ge-top')
                                .addClass('ge-fixed')
                            ;
                        }
                    } else {
                        if (wrapper.hasClass('ge-fixed')) {
                            wrapper
                                .css({ left: '', width: '' })
                                .removeClass('ge-fixed')
                                .addClass('ge-top')
                            ;
                        }
                    }
                });

                /* Init RTE on click */
                canvas.on('click', '.ge-content', function(e) {
                    var rte = getRTE($(this).data('ge-content-type'));
                    if (rte) {
                        rte.init(settings, $(this));
                    }
                });
            }

            function reset() {
                deinit();
                init();
            }

            function init() {
                runFilter(true);
                canvas.addClass('ge-editing');
                addAllColClasses();
                wrapContent();
                createRowControls();
                createColControls();
                makeSortable();
                switchLayout(curColClassIndex);
            }

            function deinit() {
                canvas.removeClass('ge-editing');
                var contents = canvas.find('.ge-content').each(function() {
                    var content = $(this);
                    getRTE(content.data('ge-content-type')).deinit(settings, content);
                });
                canvas.find('.ge-tools-drawer').remove();
                removeSortable();
                runFilter();
            }

            function createRowControls() {
                canvas.find('.row').each(function() {
                    var row = $(this);
                    if (row.find('> .ge-tools-drawer').length) { return; }

                    var drawer = $('<div class="ge-tools-drawer" />').prependTo(row);
                    createTool(drawer, 'Move', 'ge-move', 'fa-ellipsis-h');
                    createTool(drawer, 'Settings', '', 'fa-cog', function() {
                        details.toggle();
                    });
                    settings.row_tools.forEach(function(t) {
                        createTool(drawer, t.title || '', t.className || '', t.iconClass || 'glyphicon-wrench', t.on);
                    });
                    createTool(drawer, 'Remove row', 'delete pull-right', 'fa-times', function() {
                        var data_modal  ={};
                        data_modal.title="<i class='fa fa-exclamation-triangle'></i> Cảnh báo";
                        data_modal.body="<p>Bạn mới xóa phần này ?. Dữ liệu sẽ bị mất</p>";
                        data_modal.type="danger";
                        data_modal.saveText="Xóa";
                        data_modal.callback = function () {
                            row.slideUp(function() {
                                row.remove();
                            });
                            $("#" + bootstrap().modal.name_modal).modal('hide');
                        }
                        bootstrap().modal.init(data_modal);
                        $("#"+bootstrap().modal.name_modal).modal('show');
                    });
                    createTool(drawer, 'Add column', 'ge-add-column', 'fa-plus', function() {
                        row.append(createColumn(3));
                        init();
                    });

                    var details = createDetails(row, settings.row_classes).appendTo(drawer);
                });
            }

            function createColControls() {
                canvas.find('.column').each(function() {
                    var col = $(this);
                    if (col.find('> .ge-tools-drawer').length) { return; }

                    var drawer = $('<div class="ge-tools-drawer" />').prependTo(col);

                    createTool(drawer, 'Move', 'ge-move', 'fa-ellipsis-h');
                    createTool(drawer, 'Make column narrower\n(hold shift for min)', 'ge-decrease-col-width', 'fa-chevron-left', function(e) {
                        var colSizes = settings.valid_col_sizes;
                        var curColClass = colClasses[curColClassIndex];
                        var curColSizeIndex = colSizes.indexOf(getColSize(col, curColClass));
                        var newSize = colSizes[clamp(curColSizeIndex - 1, 0, colSizes.length - 1)];
                        if (e.shiftKey) {
                            newSize = colSizes[0];
                        }
                        setColSize(col, curColClass, Math.max(newSize, 1));
                    });

                    createTool(drawer, 'Make column wider\n(hold shift for max)', 'ge-increase-col-width', 'fa-chevron-right', function(e) {
                        var colSizes = settings.valid_col_sizes;
                        var curColClass = colClasses[curColClassIndex];
                        var curColSizeIndex = colSizes.indexOf(getColSize(col, curColClass));
                        var newColSizeIndex = clamp(curColSizeIndex + 1, 0, colSizes.length - 1);
                        var newSize = colSizes[newColSizeIndex];
                        if (e.shiftKey) {
                            newSize = colSizes[colSizes.length - 1];
                        }
                        setColSize(col, curColClass, Math.min(newSize, MAX_COL_SIZE));
                    });

                    createTool(drawer, 'Settings', '', 'fa-cog', function() {
                        details.toggle();
                    });

                    settings.col_tools.forEach(function(t) {
                        createTool(drawer, t.title || '', t.className || '', t.iconClass || 'glyphicon-wrench', t.on);
                    });

                    createTool(drawer, 'Remove col', 'delete pull-right', 'fa-times', function() {
                        var data_modal  ={};
                        data_modal.title="<i class='fa fa-exclamation-triangle'></i> Cảnh báo";
                        data_modal.body="<p>Bạn mới xóa column phần này ?. Dữ liệu sẽ bị mất</p>";
                        data_modal.type="danger";
                        data_modal.saveText="Xóa";
                        data_modal.callback = function () {
                            col.animate({
                                opacity: 'hide',
                                width: 'hide',
                                height: 'hide'
                            }, 400, function() {
                                col.remove();
                            });
                            $("#" + bootstrap().modal.name_modal).modal('hide');
                        }
                        bootstrap().modal.init(data_modal);
                        $("#"+bootstrap().modal.name_modal).modal('show');
                    });
                    createTool(drawer, 'Add row', 'ge-add-row', 'fa-plus', function() {
                        var row = createRow();
                        col.append(row);
                        row.append(createColumn(6)).append(createColumn(6));
                        init();
                    });
                    var details = createDetails(col, settings.col_classes).appendTo(drawer);
                });
            }

            function createTool(drawer, title, className, iconClass, eventHandlers) {
                var tool = $('<a title="' + title + '" class="' + className + '"><span class="fa ' + iconClass + '"></span></a>').appendTo(drawer);
                if (typeof eventHandlers == 'function') {
                    tool.on('click', eventHandlers);
                }
                if (typeof eventHandlers == 'object') {
                    $.each(eventHandlers, function(name, func) {
                        tool.on(name, func);
                    });
                }
            }

            function createDetails(container, cssClasses) {
                var detailsDiv = $('<div class="ge-details" />');
                container.attr('id', container.attr('id') ? container.attr('id'): "row-"+(new  Date()).getTime());
                $('<input class="item-setting" />')
                    .attr('placeholder', 'id')
                    .val(container.attr('id'))
                    .attr('title', 'Set a unique identifier')
                    .appendTo(detailsDiv)
                    .change(function() {
                        container.attr('id', this.value);
                });

                var classGroup = $('<div class="btn-group" />').appendTo(detailsDiv);
                cssClasses.forEach(function(rowClass) {
                    var btn = $('<a class="item-setting btn btn-xs btn-default" />')
                        .html(rowClass.label)
                        .attr('title', rowClass.title ? rowClass.title : 'Toggle "' + rowClass.label + '" styling')
                        .toggleClass('active btn-primary', container.hasClass(rowClass.cssClass))
                        .on('click', function() {
                            btn.toggleClass('active btn-primary');
                            container.toggleClass(rowClass.cssClass, btn.hasClass('active'));
                        })
                        .appendTo(classGroup)
                    ;
                });
                settings.row_setting.forEach(function(item_setting) {
                    var setting = $('<input class="item-setting" id="'+item_setting.id+'" />')
                        .attr('placeholder', item_setting.label)
                        .val('')
                        .attr('title', item_setting.label)
                        .appendTo(detailsDiv)
                        .change(function() {
                            container.data(item_setting.id, this.value);
                        });
                        if (typeof item_setting.click == 'function') {
                            setting.on('click', item_setting.click);
                        }
                        if (typeof item_setting.on == 'object') {

                            $.each(item_setting.on, function(name, func) {
                                setting.on(name, func);
                            });
                        }
                });

                return detailsDiv;
            }

            function addAllColClasses() {
                canvas.find('.column, div[class*="col-"]').each(function() {
                    var col = $(this);

                    var size = 2;
                    var sizes = getColSizes(col);
                    if (sizes.length) {
                        size = sizes[0].size;
                    }

                    var elemClass = col.attr('class');
                    colClasses.forEach(function(colClass) {
                        if (elemClass.indexOf(colClass) == -1) {
                            col.addClass(colClass + size);
                        }
                    });

                    col.addClass('column');
                });
            }

            /**
             * Return the column size for colClass, or a size from a different
             * class if it was not found.
             * Returns null if no size whatsoever was found.
             */
            function getColSize(col, colClass) {
                var sizes = getColSizes(col);
                for (var i = 0; i < sizes.length; i++) {
                    if (sizes[i].colClass == colClass) {
                        return sizes[i].size;
                    }
                }
                if (sizes.length) {
                    return sizes[0].size;
                }
                return null;
            }

            function getColSizes(col) {
                var result = [];
                colClasses.forEach(function(colClass) {
                    var re = new RegExp(colClass + '(\\d+)', 'i');
                    if (re.test(col.attr('class'))) {
                        result.push({
                            colClass: colClass,
                            size: parseInt(re.exec(col.attr('class'))[1])
                        });
                    }
                });
                return result;
            }

            function setColSize(col, colClass, size) {
                var re = new RegExp('(' + colClass + '(\\d+))', 'i');
                var reResult = re.exec(col.attr('class'));
                if (reResult && parseInt(reResult[2]) !== size) {
                    col.switchClass(reResult[1], colClass + size, 50);
                } else {
                    col.addClass(colClass + size);
                }
            }

            function makeSortable() {
                canvas.find('.row').sortable({
                    items: '> .column',
                    connectWith: '.ge-canvas .row',
                    handle: '> .ge-tools-drawer .ge-move',
                    start: sortStart,
                    helper: 'clone',
                    update: sortUpdate
                });
                canvas.add(canvas.find('.column')).sortable({
                    items: '> .row, > .ge-content',
                    connectsWith: '.ge-canvas, .ge-canvas .column',
                    handle: '> .ge-tools-drawer .ge-move',
                    start: sortStart,
                    helper: 'clone',
                    update: sortUpdate
                });

                function sortStart(e, ui) {
                    ui.placeholder.css({ height: ui.item.outerHeight()});
                }
                function sortUpdate(e, ui) {
                    console.log("After sort");
                }
            }

            function removeSortable() {
                canvas.add(canvas.find('.column')).add(canvas.find('.row')).sortable('destroy');
            }

            function createRow() {
                return $('<div class="row" />');
            }

            function createColumn(size) {
                return $('<div/>')
                    .addClass(colClasses.map(function(c) { return c + size; }).join(' ')).addClass(" col-xs-12")
                    .append(createDefaultContentWrapper().html(getRTE(settings.content_types[0]).initialContent));
            }

            /**
             * Run custom content filter on init and deinit
             */
            function runFilter(isInit) {
                if (settings.custom_filter.length) {
                    $.each(settings.custom_filter, function(key, func) {
                        if (typeof func == 'string') {
                            func = window[func];
                        }

                        func(canvas, isInit);
                    });
                }
            }

            /**
             * Wrap column content in <div class="ge-content"> where neccesary
             */
            function wrapContent() {
                canvas.find('.column').each(function() {
                    var col = $(this);
                    var contents = $();
                    col.children().each(function() {
                        var child = $(this);
                        if (child.is('.row, .ge-tools-drawer, .ge-content')) {
                            doWrap(contents);
                        } else {
                            contents = contents.add(child);
                        }
                    });
                    doWrap(contents);
                });
            }
            function doWrap(contents) {
                if (contents.length) {
                    var container = createDefaultContentWrapper().insertAfter(contents.last());
                    contents.appendTo(container);
                    contents = $();
                }
            }

            function createDefaultContentWrapper() {
                return $('<div/>')
                    .addClass('ge-content ge-content-type-' + settings.content_types[0])
                    .attr('data-ge-content-type', settings.content_types[0])
                    ;
            }

            function switchLayout(colClassIndex) {
                curColClassIndex = colClassIndex;

                var layoutClasses = ['ge-layout-desktop', 'ge-layout-tablet', 'ge-layout-phone'];
                layoutClasses.forEach(function(cssClass, i) {
                    canvas.toggleClass(cssClass, i == colClassIndex);
                });
            }

            function getRTE(type) {
                return $.fn.gridEditor.RTEs[type];
            }

            function clamp(input, min, max) {
                return Math.min(max, Math.max(min, input));
            }
            function bootstrap() {
                return $.fn.gridEditor.bootstrap;
            }
            baseElem.data('grideditor', {
                bootstrap: bootstrap,
                init: init,
                deinit: deinit,
            });
            $.fn.gridEditor.bootstrap.modal.init();
        });

        return self;
    };

    $.fn.gridEditor.RTEs = {};
    $.fn.gridEditor.bootstrap = {};


})( jQuery );
(function() {
    $.fn.gridEditor.RTEs.ckeditor = {

        init: function(settings, contentAreas) {

            if (!window.CKEDITOR) {
                console.error(
                    'CKEditor not available! Make sure you loaded the ckeditor and jquery adapter js files.'
                );
            }

            var self = this;
            contentAreas.each(function() {
                var contentArea = $(this);
                if (!contentArea.hasClass('active')) {
                    if (contentArea.html() == self.initialContent) {
                        // CKEditor kills this '&nbsp' creating a non usable box :/ 
                        contentArea.html('&nbsp;');
                    }

                    // Add the .attr('contenteditable',''true') or CKEditor loads readonly
                    contentArea.addClass('active').attr('contenteditable', 'true');

                    var configuration = $.extend(
                        {},
                        (settings.ckeditor && settings.ckeditor.config ? settings.ckeditor.config : {}),
                        {
                            // Focus editor on creation
                            on: {
                                instanceReady: function( evt ) {
                                    // Call original instanceReady function, if one was passed in the config
                                    var callback;
                                    try {
                                        callback = settings.ckeditor.config.on.instanceReady;
                                    } catch (err) {
                                        // No callback passed
                                    }
                                    if (callback) {
                                        callback.call(this, evt);
                                    }

                                    instance.focus();
                                }
                            }
                        }
                    );
                    var instance = CKEDITOR.inline(contentArea.get(0), configuration);
                }
            });
        },

        deinit: function(settings, contentAreas) {
            contentAreas.filter('.active').each(function() {
                var contentArea = $(this);

                // Destroy all CKEditor instances
                $.each(CKEDITOR.instances, function(_, instance) {
                    instance.destroy();
                });

                // Cleanup
                contentArea
                    .removeClass('active cke_focus')
                    .removeAttr('id')
                    .removeAttr('style')
                    .removeAttr('spellcheck')
                    .removeAttr('contenteditable')
                ;
            });
        },

        initialContent: '<p>Lorem initius... </p>',
    };
})();
(function() {

    $.fn.gridEditor.RTEs.summernote = {

        init: function(settings, contentAreas) {

            if (!jQuery().summernote) {
                console.error('Summernote not available! Make sure you loaded the Summernote js file.');
            }

            var self = this;
            contentAreas.each(function() {
                var contentArea = $(this);
                if (!contentArea.hasClass('active')) {
                    if (contentArea.html() == self.initialContent) {
                        contentArea.html('');
                    }
                    contentArea.addClass('active');

                    var configuration = $.extend(
                        true, // deep copy
                        {},
                        (settings.summernote && settings.summernote.config ? settings.summernote.config : {}),
                        {
                            tabsize: 2,
                            airMode: true,
                            // Focus editor on creation
                            callbacks: {
                                onInit: function() {

                                    // Call original oninit function, if one was passed in the config
                                    var callback;
                                    try {
                                        callback = settings.summernote.config.callbacks.onInit;
                                    } catch (err) {
                                        // No callback passed
                                    }
                                    if (callback) {
                                        callback.call(this);
                                    }

                                    contentArea.summernote('focus');
                                }
                            }
                        }
                    );
                    contentArea.summernote(configuration);
                }
            });
        },

        deinit: function(settings, contentAreas) {
            contentAreas.filter('.active').each(function() {
                var contentArea = $(this);
                contentArea.summernote('destroy');
                contentArea
                    .removeClass('active')
                    .removeAttr('id')
                    .removeAttr('style')
                    .removeAttr('spellcheck')
                ;
            });
        },

        initialContent: '<p>then i create dynamic text areas. Basically, someone selects they want to enter text from a drop down list. once they select it the text area is generated. when a user clicks the dropdown it calls a function that contains this code (my brackets may be messed up here...dont pay attention to that, lol, they are fine in my code, just look at the meat)</p>',
    };
})();

(function() {
    $.fn.gridEditor.RTEs.tinymce = {
        init: function(settings, contentAreas) {
            if (!window.tinymce) {
                console.error('tinyMCE not available! Make sure you loaded the tinyMCE js file.');
            }
            if (!contentAreas.tinymce) {
                console.error('tinyMCE jquery integration not available! Make sure you loaded the jquery integration plugin.');
            }
            var self = this;
            contentAreas.each(function() {
                var contentArea = $(this);
                if (!contentArea.hasClass('active')) {
                    if (contentArea.html() == self.initialContent) {
                        contentArea.html('');
                        contentArea.focus();
                    }
                    contentArea.addClass('active');
                    var configuration = $.extend(
                        {},
                        (settings.tinymce && settings.tinymce.config ? settings.tinymce.config : {}),
                        {
                            inline: true,
                            language: settings.option_tinymce.language,
                            oninit: function(editor) {
                                // Bring focus to text field
                                $('#' + editor.settings.id).focus();

                                // Call original oninit function, if one was passed in the config
                                var callback;
                                try {
                                    callback = settings.tinymce.config.oninit;
                                } catch (err) {
                                    // No callback passed
                                }

                                if (callback) {
                                    callback.call(this);
                                }
                            },
                            document_app: settings.option_tinymce.document_app,
                            plugin_url: settings.option_tinymce.plugin_url,
                            plugins: [
                                'advlist autolink lists link image imagetools charmap print preview anchor',
                                'searchreplace visualblocks code fullscreen',
                                'insertdatetime media table contextmenu paste code example shortcode textcolor help linktarget'
                            ],
                            imagetools_toolbar: "rotateleft rotateright | flipv fliph | imageoptions link unlink",
                            setup: function(ed) {
                                ed.addContextToolbar('a', 'link unlink linktarget');
                            },
                            toolbar1: 'removeformat styleselect | bold italic | alignleft aligncenter alignright alignjustify | forecolor header fontselect fontsizeselect ',
                            toolbar2: 'bullist numlist| link code image example shortcode | linktarget',
                            menubar: false
                        }
                    );
                    var tiny = contentArea.tinymce(configuration);
                }
            });
        },

        deinit: function(settings, contentAreas) {
            contentAreas.filter('.active').each(function() {
                var contentArea = $(this);
                var tiny = contentArea.tinymce();
                if (tiny) {
                    tiny.remove();
                }
                contentArea
                    .removeClass('active')
                    .removeAttr('id')
                    .removeAttr('style')
                    .removeAttr('spellcheck')
                ;
            });
        },

        initialContent: '<p>then i create dynamic text areas. Basically, someone selects they want to enter text from a drop down list. once they select it the text area is generated. when a user clicks the dropdown it calls a function that contains this code (my brackets may be messed up here...dont pay attention to that, lol, they are fine in my code, just look at the meat)</p>',
    };
})();

(function() {
    $.fn.gridEditor.bootstrap.modal = {
        name_modal: 'ge-modal-info',
        init:function (data) {
                    var modal = this;
                    var data_default = {
                        title: 'Test title modal',
                        body:'<p class="text-center">Load body in here !</p>',
                        saveText:'Lưu',
                        size:'modal-sm',
                        type:'info',
                        callback: ''
                    };
                    if($(document).find('#ge-modal-info').size()==0){
                        modal.addHtml(data_default);
                    }else{
                        modal.addHtml($.extend(data_default,data));
                    }
        },
        addHtml:function(data_modal){
            var modal = this;
            var html_modal = '<div id="'+modal.name_modal+'" class="modal fade" tabindex="-1" role="dialog">';
            html_modal += '<div class="modal-dialog '+data_modal.size+'" role="document">';
            html_modal += '<div class="modal-content">';
            html_modal += '<div class="modal-header">';
            html_modal += '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
            html_modal += '<h3 class="modal-title">'+data_modal.title+'</h3>';
            html_modal += '</div>';
            html_modal += '<div class="modal-body">';
            html_modal += data_modal.body;
            html_modal += '</div>';
            html_modal += '<div class="modal-footer">';
            html_modal += '<button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>';
            if(data_modal.type == 'info')
                html_modal += '<button type="button" id="ge-save-modal" class="btn btn-primary">'+data_modal.saveText+'</button>';
            if(data_modal.type == 'danger')
                html_modal += '<button type="button" id="ge-save-modal" class="btn btn-danger">'+data_modal.saveText+'</button>';
            html_modal += '</div>';
            html_modal += '</div>';
            html_modal += '</div>';
            html_modal += '</div>';
            $(document.body).find("#"+modal.name_modal).remove();
            $(html_modal).appendTo(document.body);
            if(typeof data_modal.callback=='function') {
                $("#" + modal.name_modal).on("click", "#ge-save-modal", data_modal.callback);
            }
        },
        deinit:function () {
            
        }
    }
})();
