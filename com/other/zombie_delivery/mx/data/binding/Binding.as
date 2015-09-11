class mx.data.binding.Binding
{
    var is2way, dest, source, value, format, value2, immediate, binding;
    function Binding(source, dest, format, is2way)
    {
        mx.events.EventDispatcher.initialize(this);
        var _loc5 = this;
        _loc5.source = source;
        _loc5.dest = dest;
        _loc5.format = format;
        _loc5.is2way = is2way;
        mx.data.binding.Binding.registerBinding(this);
        this.calcShortLoc(source);
        this.calcShortLoc(dest);
        _global.__dataLogger.logData(null, "Creating binding " + this.summaryString() + (is2way ? (", 2-way") : ("")), {binding: this});
        ++_global.__dataLogger.nestLevel;
        mx.data.binding.ComponentMixins.initComponent(dest.component);
        if (source.component != undefined)
        {
            mx.data.binding.ComponentMixins.initComponent(source.component);
        } // end if
        dest.component.addBinding(this);
        if (source.component != undefined)
        {
            source.component.addBinding(this);
            this.setUpListener(source, false);
            if (this.is2way)
            {
                this.setUpListener(dest, true);
                this.setUpIndexListeners(source, false);
                this.setUpIndexListeners(dest, true);
            }
            else
            {
                this.setUpIndexListeners(source, false);
                this.setUpIndexListeners(dest, false);
            } // end else if
        }
        else
        {
            this.execute();
        } // end else if
        --_global.__dataLogger.nestLevel;
    } // End of the function
    function execute(reverse)
    {
        var _loc3;
        var _loc4;
        if (reverse)
        {
            if (!is2way)
            {
                _global.__dataLogger.logData(null, "Warning: Can\'t execute binding " + this.summaryString(false) + " in reverse, because it\'s not a 2 way binding", {binding: this}, mx.data.binding.Log.BRIEF);
                return (["error"]);
            } // end if
            _loc3 = dest;
            _loc4 = source;
        }
        else
        {
            _loc3 = source;
            _loc4 = dest;
        } // end else if
        _global.__dataLogger.logData(null, "Executing binding " + this.summaryString(reverse), {binding: this});
        ++_global.__dataLogger.nestLevel;
        var _loc10;
        if (_loc3.constant != undefined)
        {
            _loc10 = {value: new mx.data.binding.TypedValue(_loc3.constant, "String"), getAnyTypedValue: function ()
            {
                return (value);
            }, getTypedValue: function ()
            {
                return (value);
            }, getGettableTypes: function ()
            {
                return (["String"]);
            }};
        }
        else
        {
            _loc10 = _loc3.component.getField(_loc3.property, _loc3.location, true);
        } // end else if
        var _loc18;
        var _loc20;
        var _loc12 = "";
        var _loc8 = _loc4.component.getField(_loc4.property, _loc4.location);
        if (format != null)
        {
            var _loc5 = mx.data.binding.Binding.getRuntimeObject(format);
            if (_loc5 != null)
            {
                if (reverse)
                {
                    _loc5.setupDataAccessor(_loc4.component, _loc4.property, _loc4.location);
                    _loc5.dataAccessor = _loc8;
                    _loc8 = _loc5;
                }
                else
                {
                    _loc5.setupDataAccessor(_loc3.component, _loc3.property, _loc3.location);
                    _loc5.dataAccessor = _loc10;
                    _loc10 = _loc5;
                } // end if
            } // end if
        } // end else if
        var _loc14 = format == null ? (_loc8.getSettableTypes()) : (null);
        var value = _loc10.getAnyTypedValue(_loc14);
        var _loc9 = new Object();
        if (_loc8.type.readonly == true)
        {
            _global.__dataLogger.logData(null, "Not executing binding because the destination is read-only", null, mx.data.binding.Log.BRIEF);
            var _loc6 = new Object();
            _loc6.type = "invalid";
            _loc6.property = _loc4.property;
            _loc6.location = _loc4.location;
            _loc6.messages = [{message: "Cannot assign to a read-only data field."}];
            _loc4.component.dispatchEvent(_loc6);
            _loc9.event = _loc6;
        }
        else
        {
            _global.__dataLogger.logData(null, "Assigning new value \'<value>\' (<typeName>) " + _loc12, {value: value.value, typeName: value.typeName, unformattedValue: _loc18, formatterFrom: _loc20});
            var _loc13 = _loc8.setAnyTypedValue(value);
            _loc8.validateAndNotify(_loc9, false, _loc13);
            _loc4.component.dispatchEvent({type: "bindingExecuted", binding: this});
        } // end else if
        if (_loc9.event != null)
        {
            if (_loc3.component != null)
            {
                var _loc7 = new Object();
                _loc7.type = _loc9.event.type;
                _loc7.property = _loc3.property;
                _loc7.location = _loc3.location;
                _loc7.messages = _loc9.event.messages;
                _loc7.to = _loc4.component;
                _loc3.component.dispatchEvent(_loc7);
            } // end if
        } // end if
        --_global.__dataLogger.nestLevel;
        return (_loc9.event.messages);
    } // End of the function
    function queueForExecute(reverse)
    {
        if (!queued)
        {
            if (_global.__databind_executeQueue == null)
            {
                _global.__databind_executeQueue = new Array();
            } // end if
            if (_root.__databind_dispatch == undefined)
            {
                _root.createEmptyMovieClip("__databind_dispatch", -8888);
            } // end if
            _global.__databind_executeQueue.push(this);
            queued = true;
            this.reverse = reverse;
            _root.__databind_dispatch.onEnterFrame = mx.data.binding.Binding.dispatchEnterFrame;
            
        } // end if
    } // End of the function
    static function dispatchEnterFrame()
    {
        _root.__databind_dispatch.onEnterFrame = null;
        for (var _loc4 = 0; _loc4 < _global.__databind_executeQueue.length; ++_loc4)
        {
            var _loc3 = _global.__databind_executeQueue[_loc4];
            _loc3.execute(_loc3.reverse);
        } // end of for
        var _loc5;
        while (_loc5 = _global.__databind_executeQueue.pop(), _global.__databind_executeQueue.pop() != null)
        {
            _loc5.queued = false;
            _loc5.reverse = false;
        } // end while
    } // End of the function
    function calcShortLoc(endpoint)
    {
        var _loc1 = endpoint.location;
        if (_loc1.path != null)
        {
            _loc1 = _loc1.path;
        } // end if
        endpoint.loc = _loc1 instanceof Array ? (_loc1.join(".")) : (_loc1);
    } // End of the function
    function summaryString(reverse)
    {
        var _loc2 = "<binding.dest.component>:<binding.dest.property>:<binding.dest.loc>";
        var _loc3 = "<binding.source.component>:<binding.source.property>:<binding.source.loc>";
        if (source.constant == null)
        {
            if (reverse == true)
            {
                return ("from " + _loc2 + " to " + _loc3);
            }
            else
            {
                return ("from " + _loc3 + " to " + _loc2);
            } // end else if
        }
        else
        {
            return ("from constant \'<binding.source.constant>\' to " + _loc2);
        } // end else if
    } // End of the function
    static function getRuntimeObject(info, constructorParameter)
    {
        if (info.cls == undefined)
        {
            info.cls = mx.utils.ClassFinder.findClass(info.className);
        } // end if
        var _loc3 = new info.cls(constructorParameter);
        if (_loc3 == null)
        {
            _global.__dataLogger.logData(null, "Could not construct a formatter or validator - new <info.className>(<params>)", {info: info, params: constructorParameter}, mx.data.binding.Log.BRIEF);
        } // end if
        for (var _loc4 in info.settings)
        {
            _loc3[_loc4] = info.settings[_loc4];
        } // end of for...in
        return (_loc3);
    } // End of the function
    static function refreshFromSources(component, property, bindings)
    {
        var _loc5 = null;
        var _loc3;
        for (var _loc3 = 0; _loc3 < bindings.length; ++_loc3)
        {
            var _loc1 = bindings[_loc3];
            var _loc2 = null;
            if (_loc1.dest.component == component && (property == null || property == _loc1.dest.property))
            {
                _loc2 = _loc1.execute();
            }
            else if (_loc1.is2way && _loc1.source.component == component && (property == null || property == _loc1.source.property))
            {
                _loc2 = _loc1.execute(true);
            } // end else if
            if (_loc2 != null)
            {
                _loc5 = _loc5 == null ? (_loc2) : (_loc5.concat(_loc2));
            } // end if
        } // end of for
        return (_loc5);
    } // End of the function
    static function refreshDestinations(component, bindings)
    {
        var _loc1;
        for (var _loc1 = 0; _loc1 < bindings.length; ++_loc1)
        {
            var _loc2 = bindings[_loc1];
            if (_loc2.source.component == component)
            {
                _loc2.execute();
                continue;
            } // end if
            if (_loc2.is2way && _loc2.dest.component == component)
            {
                _loc2.execute(true);
            } // end if
        } // end of for
        for (var _loc1 = 0; _loc1 < component.__indexBindings.length; ++_loc1)
        {
            var _loc3 = component.__indexBindings[_loc1];
            _loc3.binding.execute(_loc3.reverse);
        } // end of for
    } // End of the function
    static function okToCallGetterFromSetter()
    {
        function setter(val)
        {
            value2 = value;
        } // End of the function
        function getter()
        {
            return (5);
        } // End of the function
        var _loc2 = new Object();
        _loc2.addProperty("value", getter, setter);
        _loc2.value = 0;
        var _loc3 = _loc2.value2 == _loc2.value;
        return (_loc3);
    } // End of the function
    function setUpListener(endpoint, reverse)
    {
        var _loc4 = new Object();
        _loc4.binding = this;
        _loc4.property = endpoint.property;
        _loc4.reverse = reverse;
        _loc4.immediate = mx.data.binding.Binding.okToCallGetterFromSetter();
        _loc4.handleEvent = function (event)
        {
            _global.__dataLogger.logData(event.target, "Data of property \'<property>\' has changed. <immediate>.", this);
            if (immediate)
            {
                if (binding.executing != true)
                {
                    binding.executing = true;
                    binding.execute(this.reverse);
                    binding.executing = false;
                } // end if
            }
            else
            {
                binding.queueForExecute(this.reverse);
            } // end else if
        };
        if (endpoint.event instanceof Array)
        {
            for (var _loc5 in endpoint.event)
            {
                endpoint.component.__addHighPrioEventListener(endpoint.event[_loc5], _loc4);
            } // end of for...in
        }
        else
        {
            endpoint.component.__addHighPrioEventListener(endpoint.event, _loc4);
        } // end else if
        mx.data.binding.ComponentMixins.initComponent(endpoint.component);
    } // End of the function
    function setUpIndexListeners(endpoint, reverse)
    {
        if (endpoint.location.indices != undefined)
        {
            for (var _loc3 = 0; _loc3 < endpoint.location.indices.length; ++_loc3)
            {
                var _loc2 = endpoint.location.indices[_loc3];
                if (_loc2.component != undefined)
                {
                    this.setUpListener(_loc2, reverse);
                    if (_loc2.component.__indexBindings == undefined)
                    {
                        _loc2.component.__indexBindings = new Array();
                    } // end if
                    _loc2.component.__indexBindings.push({binding: this, reverse: reverse});
                } // end if
            } // end of for
        } // end if
    } // End of the function
    static function copyBinding(b)
    {
        var _loc1 = new Object();
        _loc1.source = mx.data.binding.Binding.copyEndPoint(b.source);
        _loc1.dest = mx.data.binding.Binding.copyEndPoint(b.dest);
        _loc1.format = b.format;
        _loc1.is2way = b.is2way;
        return (_loc1);
    } // End of the function
    static function copyEndPoint(e)
    {
        var _loc1 = new Object();
        _loc1.constant = e.constant;
        _loc1.component = String(e.component);
        _loc1.event = e.event;
        _loc1.location = e.location;
        _loc1.property = e.property;
        return (_loc1);
    } // End of the function
    static function registerScreen(screen, id)
    {
        var symbol = mx.data.binding.Binding.screenRegistry[id];
        if (symbol == null)
        {
            mx.data.binding.Binding.screenRegistry[id] = {symbolPath: String(screen), bindings: [], id: id};
            return;
        } // end if
        if (symbol.symbolPath == String(screen))
        {
            return;
        } // end if
        var instancePath = String(screen);
        var i = 0;
        while (i < mx.data.binding.Binding.bindingRegistry.length)
        {
            var b = mx.data.binding.Binding.bindingRegistry[i];
            var src = mx.data.binding.Binding.copyEndPoint(b.source);
            var dst = mx.data.binding.Binding.copyEndPoint(b.dest);
            var prefix = symbol.symbolPath + ".";
            var symbolContainsSource = prefix == b.source.component.substr(0, prefix.length);
            var symbolContainsDest = prefix == b.dest.component.substr(0, prefix.length);
            if (symbolContainsSource)
            {
                if (symbolContainsDest)
                {
                    src.component = eval(instancePath + src.component.substr(symbol.symbolPath.length));
                    dst.component = eval(instancePath + dst.component.substr(symbol.symbolPath.length));
                    new mx.data.binding.Binding(src, dst, b.format, b.is2way);
                }
                else
                {
                    src.component = eval(instancePath + src.component.substr(symbol.symbolPath.length));
                    dst.component = eval(dst.component);
                    new mx.data.binding.Binding(src, dst, b.format, b.is2way);
                } // end else if
            }
            else if (symbolContainsDest)
            {
                src.component = eval(src.component);
                dst.component = eval(instancePath + dst.component.substr(symbol.symbolPath.length));
                new mx.data.binding.Binding(src, dst, b.format, b.is2way);
                
            } // end else if
            ++i;
        } // end while
    } // End of the function
    static function registerBinding(binding)
    {
        var _loc1 = mx.data.binding.Binding.copyBinding(binding);
        mx.data.binding.Binding.bindingRegistry.push(_loc1);
    } // End of the function
    static function getLocalRoot(clip)
    {
        var _loc2;
        var _loc3 = clip._url;
        while (clip != null)
        {
            if (clip._url != _loc3)
            {
                break;
            } // end if
            _loc2 = clip;
            clip = clip._parent;
        } // end while
        return (_loc2);
    } // End of the function
    var queued = false;
    var reverse = false;
    static var counter = 0;
    static var screenRegistry = new Object();
    static var bindingRegistry = new Array();
} // End of Class
