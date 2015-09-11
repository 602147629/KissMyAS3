class mx.data.binding.ComponentMixins
{
    var __refreshing, __bindings, __schema, __fieldCache, _eventDispatcher, __highPrioEvents, dispatchQueue, _databinding_original_dispatchEvent;
    function ComponentMixins()
    {
    } // End of the function
    function refreshFromSources()
    {
        if (__refreshing != null)
        {
            return;
        } // end if
        __refreshing = true;
        _global.__dataLogger.logData(this, "Refreshing from sources");
        ++_global.__dataLogger.nestLevel;
        mx.data.binding.Binding.refreshFromSources(this, null, __bindings);
        --_global.__dataLogger.nestLevel;
        __refreshing = null;
    } // End of the function
    function refreshDestinations()
    {
        _global.__dataLogger.logData(this, "Refreshing Destinations");
        ++_global.__dataLogger.nestLevel;
        mx.data.binding.Binding.refreshDestinations(this, __bindings);
        --_global.__dataLogger.nestLevel;
    } // End of the function
    function validateProperty(property, initialMessages)
    {
        var _loc4 = null;
        var _loc3 = this.getField(property);
        if (_loc3 != null)
        {
            _loc4 = _loc3.validateAndNotify(null, null, initialMessages);
        }
        else
        {
            _global.__dataLogger.logData(this, "Can\'t validate property \'<property>\' because it doesn\'t exist", {property: property});
        } // end else if
        return (_loc4);
    } // End of the function
    function addBinding(binding)
    {
        if (__bindings == undefined)
        {
            __bindings = new Array();
        } // end if
        __bindings.push(binding);
        var _loc3 = false;
        if (binding.source.component == this)
        {
            this.getField(binding.source.property, binding.source.location);
            _loc3 = true;
        } // end if
        if (binding.dest.component == this)
        {
            this.getField(binding.dest.property, binding.dest.location);
            _loc3 = _loc3 | Object(binding).is2way;
        } // end if
        if (_loc3)
        {
            var _loc4 = binding.dest.component.findSchema(binding.dest.property, binding.dest.location);
            if (_loc4.readonly)
            {
                binding.source.component.__setReadOnly(true);
            } // end if
        } // end if
    } // End of the function
    static function initComponent(component)
    {
        var _loc2 = mx.data.binding.ComponentMixins.prototype;
        if (component.refreshFromSources == undefined)
        {
            component.refreshFromSources = _loc2.refreshFromSources;
        } // end if
        if (component.refreshDestinations == undefined)
        {
            component.refreshDestinations = _loc2.refreshDestinations;
        } // end if
        if (component.validateProperty == undefined)
        {
            component.validateProperty = _loc2.validateProperty;
        } // end if
        if (component.createFieldAccessor == undefined)
        {
            component.createFieldAccessor = _loc2.createFieldAccessor;
        } // end if
        if (component.createField == undefined)
        {
            component.createField = _loc2.createField;
        } // end if
        if (component.addBinding == undefined)
        {
            component.addBinding = _loc2.addBinding;
        } // end if
        if (component.findSchema == undefined)
        {
            component.findSchema = _loc2.findSchema;
        } // end if
        if (component.getField == undefined)
        {
            component.getField = _loc2.getField;
        } // end if
        if (component.refreshAndValidate == undefined)
        {
            component.refreshAndValidate = _loc2.refreshAndValidate;
        } // end if
        if (component.getFieldFromCache == undefined)
        {
            component.getFieldFromCache = _loc2.getFieldFromCache;
        } // end if
        if (component.getBindingMetaData == undefined)
        {
            component.getBindingMetaData = _loc2.getBindingMetaData;
        } // end if
        if (component.__setReadOnly == undefined)
        {
            component.__setReadOnly = _loc2.__setReadOnly;
        } // end if
        if (component.__addHighPrioEventListener == undefined)
        {
            component.__addHighPrioEventListener = _loc2.__addHighPrioEventListener;
        } // end if
    } // End of the function
    function createFieldAccessor(property, location, mustExist)
    {
        return (mx.data.binding.FieldAccessor.createFieldAccessor(this, property, location, mx.data.binding.FieldAccessor.findElementType(__schema, property), mustExist));
    } // End of the function
    function findSchema(property, location)
    {
        if (typeof(location) == "string")
        {
            if (mx.data.binding.FieldAccessor.isActionScriptPath(String(location)))
            {
                location = location.split(".");
            }
            else
            {
                return (null);
            } // end if
        } // end else if
        var _loc5 = mx.data.binding.FieldAccessor.findElementType(__schema, property);
        if (location != null)
        {
            if (location.path != null)
            {
                location = location.path;
            } // end if
            if (!(location instanceof Array))
            {
                return (null);
            } // end if
            for (var _loc2 = 0; _loc2 < location.length; ++_loc2)
            {
                var _loc4 = location[_loc2];
                _loc5 = mx.data.binding.FieldAccessor.findElementType(_loc5, _loc4);
            } // end of for
        } // end if
        return (_loc5);
    } // End of the function
    function createField(property, location)
    {
        var _loc3 = this.findSchema(property, location);
        var _loc2;
        if (_loc3.validation != null)
        {
            _loc2 = mx.data.binding.Binding.getRuntimeObject(_loc3.validation);
        }
        else
        {
            _loc2 = new mx.data.binding.DataType();
        } // end else if
        _loc2.setupDataAccessor(this, property, location);
        return (_loc2);
    } // End of the function
    static function deepEqual(a, b)
    {
        if (a == b)
        {
            return (true);
        } // end if
        if (typeof(a) != typeof(b))
        {
            return (false);
        } // end if
        if (typeof(a) != "object")
        {
            return (false);
        } // end if
        var _loc3 = new Object();
        for (var _loc4 in a)
        {
            if (!mx.data.binding.ComponentMixins.deepEqual(a[_loc4], b[_loc4]))
            {
                return (false);
            } // end if
            _loc3[_loc4] = 1;
        } // end of for...in
        for (var _loc4 in b)
        {
            if (_loc3[_loc4] != 1)
            {
                return (false);
            } // end if
        } // end of for...in
        return (true);
    } // End of the function
    function getFieldFromCache(property, location)
    {
        for (var _loc5 in __fieldCache)
        {
            var _loc2 = __fieldCache[_loc5];
            if (_loc2.property == property && mx.data.binding.ComponentMixins.deepEqual(_loc2.location, location))
            {
                return (_loc2);
            } // end if
        } // end of for...in
        return (null);
    } // End of the function
    function getField(property, location)
    {
        var _loc2 = this.getFieldFromCache(property, location);
        if (_loc2 != null)
        {
            return (_loc2);
        } // end if
        _loc2 = this.createField(property, location);
        if (__fieldCache == null)
        {
            __fieldCache = new Array();
        } // end if
        __fieldCache.push(_loc2);
        return (_loc2);
    } // End of the function
    function refreshAndValidate(property)
    {
        _global.__dataLogger.logData(this, "Refreshing and validating " + property);
        ++_global.__dataLogger.nestLevel;
        var _loc3 = mx.data.binding.Binding.refreshFromSources(this, property, __bindings);
        _loc3 = this.validateProperty(property, _loc3);
        --_global.__dataLogger.nestLevel;
        return (_loc3 == null);
    } // End of the function
    function getBindingMetaData(name)
    {
        return (this["__" + name]);
    } // End of the function
    function __setReadOnly(setting)
    {
        if (Object(this).editable != undefined)
        {
            Object(this).editable = !setting;
        } // end if
    } // End of the function
    function __addHighPrioEventListener(event, handler)
    {
        var _loc3 = _eventDispatcher != undefined ? (_eventDispatcher) : (this);
        if (_loc3.__highPrioEvents == undefined)
        {
            _loc3.__highPrioEvents = new Object();
        } // end if
        var _loc4 = "__q_" + event;
        if (_loc3.__highPrioEvents[_loc4] == undefined)
        {
            _loc3.__highPrioEvents[_loc4] = new Array();
        } // end if
        _global.ASSetPropFlags(_loc3.__highPrioEvents, _loc4, 1);
        mx.events.EventDispatcher._removeEventListener(_loc3.__highPrioEvents[_loc4], event, handler);
        _loc3.__highPrioEvents[_loc4].push(handler);
        if (_loc3._databinding_original_dispatchEvent == undefined)
        {
            _loc3._databinding_original_dispatchEvent = _loc3.dispatchEvent;
            _loc3.dispatchEvent = function (eventObj)
            {
                if (eventObj.target == undefined)
                {
                    eventObj.target = this;
                } // end if
                this.dispatchQueue(__highPrioEvents, eventObj);
                this._databinding_original_dispatchEvent(eventObj);
            };
        } // end if
    } // End of the function
} // End of Class
