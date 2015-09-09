class mx.data.components.DataSet extends MovieClip
{
    var _loading, _eventDispatcher, super_addBinding, _fldValObj, __schema, __toProperties, _calcFields, _enableEvents, _event, _itemClass, _hasDelta, _deltaPacket, _filterFunc, _visible, _filtered, _srcSchema, _defValues, _name, __logChanges, __readOnly, __itemClassName, _trapProperties, __curItem, _dpIndexByTransId, _iterator, getField, __get__deltaPacket, __get__length, __get__dataProvider, __get__filtered, __get__filterFunc, __items, __get__items, __get__itemClassName, __get__logChanges, __get__readOnly, __schemaXML, _invalidSchema, __get__schema, __get__selectedIndex, _iterators, _itemIndexById, _dpTransIdCount, _lastTransId, _deltaItems, _optDeltaItems, _propCage, __set__items, addProperty, __set__schema, __get__currentItem, __set__dataProvider, __set__deltaPacket, __set__filterFunc, __set__filtered, __set__itemClassName, __set__logChanges, __get__properties, __set__readOnly, __set__selectedIndex;
    function DataSet()
    {
        super();
        _loading = false;
        _eventDispatcher = new Object();
        mx.events.EventDispatcher.initialize(_eventDispatcher);
        super_addBinding = mx.data.binding.ComponentMixins.prototype.addBinding;
        _fldValObj = new Object();
        _fldValObj.__schema = __schema;
        mx.data.binding.ComponentMixins.initComponent(_fldValObj);
        mx.data.binding.ComponentMixins.initComponent(this);
        __toProperties = new Object();
        _calcFields = new Object();
        _calcFields.__length__ = 0;
        this.initCollection();
        this.initIterators();
        _enableEvents = 0;
        _event = null;
        _itemClass = null;
        _hasDelta = 0;
        _deltaPacket = null;
        _filterFunc = null;
        _visible = false;
        _filtered = false;
        _srcSchema = null;
        _defValues = new Object();
        _name = _name == undefined ? ("") : (_name);
        __logChanges = __logChanges == undefined ? (true) : (__logChanges);
        __readOnly = __readOnly == undefined ? (false) : (__readOnly);
        __itemClassName = __itemClassName == undefined ? ("") : (__itemClassName);
        _trapProperties = false;
        this.buildSchema();
        this.createProperties();
    } // End of the function
    function get currentItem()
    {
        return (__curItem);
    } // End of the function
    function get deltaPacket()
    {
        return (_deltaPacket);
    } // End of the function
    function set deltaPacket(dp)
    {
        if (dp != null)
        {
            var _loc9 = dp.getIterator();
            var _loc5;
            var _loc13 = new Array();
            var _loc12 = _dpIndexByTransId[dp.getTransactionId()];
            if (_loc12 != undefined)
            {
                this.internalClearDeltaPacket(dp.getTransactionId());
                while (_loc9.hasNext())
                {
                    _loc5 = (mx.data.components.datasetclasses.Delta)(_loc9.next());
                    if (_loc12.items[_loc5.getId()] == null)
                    {
                        throw new mx.data.components.datasetclasses.DataSetError("Couldn\'t resolve item with ID [" + _loc5.getId() + "] specified in deltaPacket [" + dp.getTransactionId() + "]. Error for DataSet \'" + _name + "\'.");
                    } // end if
                    this.applyResolvePacket(_loc5, _loc13, _loc12.items);
                } // end while
                if (_loc13.length > 0)
                {
                    this.internalDispatchEvent("resolveDelta", {data: _loc13});
                } // end if
            }
            else
            {
                var _loc3;
                var _loc15 = __logChanges;
                __logChanges = dp.logChanges() && __logChanges;
                --_enableEvents;
                var _loc14 = dp.getKeyInfo();
                this.addSort(dp.getTransactionId(), _loc14.keyList, _loc14.options);
                try
                {
                    if (_loc9.hasNext())
                    {
                        _loc5 = (mx.data.components.datasetclasses.Delta)(_loc9.next());
                        switch (_loc5.getOperation())
                        {
                            case mx.data.components.datasetclasses.DeltaPacketConsts.Modified:
                            {
                                _loc3 = _iterator.find(_loc5.getSource());
                                if (_loc3 != null)
                                {
                                    var _loc11 = __curItem;
                                    try
                                    {
                                        __curItem = _loc3;
                                        var _loc4;
                                        var _loc8 = _loc5.getChangeList();
                                        for (var _loc6 = 0; _loc6 < _loc8.length; ++_loc6)
                                        {
                                            _loc4 = _loc8[_loc6];
                                            if (_loc4.kind == mx.data.components.datasetclasses.DeltaItem.Property)
                                            {
                                                var _loc7 = __toProperties[_loc4.name].type;
                                                this.getField(_loc4.name).setTypedValue(new mx.data.binding.TypedValue(_loc4.newValue, _loc7.name, _loc7));
                                                continue;
                                            } // end if
                                            this[_loc4.name].apply(_loc3, _loc4.argList);
                                        } // end of for
                                    } // End of try
                                    finally
                                    {
                                        __curItem = _loc11;
                                    } // End of finally
                                } // end if
                                break;
                            } 
                            case mx.data.components.datasetclasses.DeltaPacketConsts.Added:
                            {
                                _loc3 = this.convertToRaw(_loc5.getSource(true));
                                _loc3 = this.createItem(_loc3);
                                this.addItem(_loc3);
                                break;
                            } 
                            case mx.data.components.datasetclasses.DeltaPacketConsts.Removed:
                            {
                                _loc3 = this.convertToRaw(_loc5.getSource());
                                _loc3 = _iterator.find(_loc3);
                                if (_loc3 != null)
                                {
                                    this.removeItem(_loc3);
                                } // end if
                                break;
                            } 
                        } // End of switch
                        if (_loc3 == null)
                        {
                            _global.__dataLogger.logData(null, "Couldn\'t find the following item:", _loc5.getSource());
                        } // end if
                    } // end if
                } // End of try
                finally
                {
                    this.removeSort(dp.getTransactionId());
                    ++_enableEvents;
                    __logChanges = _loc15;
                } // End of finally
            } // end if
        } // end else if
        //return (this.deltaPacket());
        null;
    } // End of the function
    function get dataProvider()
    {
        return (new mx.data.components.datasetclasses.DataSetDataProvider(this));
    } // End of the function
    function set dataProvider(dp)
    {
        if (dp != null)
        {
            _loading = true;
            var _loc6 = __logChanges;
            try
            {
                __logChanges = false;
                this.initCollection();
                if (dp.length > 0 && this.hasInvalidSchema())
                {
                    this.defaultSchema(dp.getItemAt(0), true);
                } // end if
                var _loc5 = _itemClass != null || __itemClassName.length > 0 || _eventDispatcher.__q_newItem != undefined;
                var _loc3;
                for (var _loc2 = 0; _loc2 < dp.length; ++_loc2)
                {
                    _loc3 = dp.getItemAt(_loc2);
                    _loc3 = _loc5 ? (this.createItem(_loc3)) : (_loc3);
                    this.internalAddItem(_loc3, _loc2, false, true);
                } // end of for
                this.rebuildItemIndexById();
                this.initIterators();
                this.internalDispatchEvent("afterLoaded");
                this.internalDispatchEvent("modelChanged", {eventName: "updateAll", firstItem: 0, lastItem: this.__get__length()});
            } // End of try
            finally
            {
                __logChanges = _loc6;
                _loading = false;
            } // End of finally
        } // end if
        //return (this.dataProvider());
        null;
    } // End of the function
    function get filtered()
    {
        return (_filtered);
    } // End of the function
    function set filtered(value)
    {
        if (_filtered != value)
        {
            if (_iterator.setFiltered(value) != 0)
            {
                __curItem = this.internalFirst();
                this.internalDispatchEvent("modelChanged", {eventName: "filterModel"});
            } // end if
            _filtered = value;
        } // end if
        //return (this.filtered());
        null;
    } // End of the function
    function get filterFunc()
    {
        return (_filterFunc);
    } // End of the function
    function set filterFunc(value)
    {
        if (_filterFunc != value)
        {
            if (_iterator.setFilterFunc(value) != 0)
            {
                __curItem = this.internalFirst();
                this.internalDispatchEvent("modelChanged", {eventName: "filterModel"});
            } // end if
            _filterFunc = value;
        } // end if
        //return (this.filterFunc());
        null;
    } // End of the function
    function get items()
    {
        return (__items);
    } // End of the function
    function set items(itms)
    {
        var _loc6 = __logChanges;
        _loading = true;
        try
        {
            __logChanges = false;
            this.initCollection();
            if (itms.length > 0 && this.hasInvalidSchema())
            {
                this.defaultSchema(itms[0]);
            } // end if
            var _loc5 = _itemClass != null || __itemClassName.length > 0 || _eventDispatcher.__q_newItem != undefined;
            var _loc3;
            for (var _loc2 = 0; _loc2 < itms.length; ++_loc2)
            {
                _loc3 = itms[_loc2];
                _loc3 = _loc5 ? (this.createItem(_loc3)) : (_loc3);
                this.internalAddItem(_loc3, _loc2, false, false);
            } // end of for
            this.rebuildItemIndexById();
            this.initIterators();
            this.internalDispatchEvent("afterLoaded");
            this.internalDispatchEvent("modelChanged", {eventName: "updateAll", firstItem: 0, lastItem: this.__get__length()});
        } // End of try
        finally
        {
            __logChanges = _loc6;
            _loading = false;
        } // End of finally
        //return (this.items());
        null;
    } // End of the function
    function get itemClassName()
    {
        return (__itemClassName);
    } // End of the function
    function set itemClassName(value)
    {
        if (__itemClassName != value && __items.length > 0)
        {
            throw new mx.data.components.datasetclasses.DataSetError("ItemClass can not be changed when there are already items in the collection. Error for DataSet \'" + _name + "\'.");
        } // end if
        __itemClassName = value;
        _itemClass = null;
        //return (this.itemClassName());
        null;
    } // End of the function
    function get length()
    {
        return (this.getLength());
    } // End of the function
    function get logChanges()
    {
        return (__logChanges);
    } // End of the function
    function set logChanges(value)
    {
        __logChanges = value;
        //return (this.logChanges());
        null;
    } // End of the function
    function get properties()
    {
        return (__toProperties);
    } // End of the function
    function get readOnly()
    {
        return (__readOnly);
    } // End of the function
    function set readOnly(value)
    {
        __readOnly = value;
        //return (this.readOnly());
        null;
    } // End of the function
    function get schema()
    {
        return (__schemaXML);
    } // End of the function
    function set schema(sch)
    {
        if (sch.firstChild.nodeName != "properties")
        {
            throw new mx.data.components.datasetclasses.DataSetError("First node of schema XML must be \'properties\'");
        } // end if
        __schema = new Object();
        __schema.elements = new Array();
        var _loc3 = sch.firstChild.childNodes;
        var _loc2;
        var _loc6;
        for (var _loc4 in _loc3)
        {
            _loc2 = _loc3[_loc4];
            if (_loc2.nodeName == "property")
            {
                __schema.elements.push(this.getSchemaObject(_loc2));
            } // end if
        } // end of for...in
        __schemaXML = sch;
        _invalidSchema = false;
        this.createProperties();
        //return (this.schema());
        null;
    } // End of the function
    function get selectedIndex()
    {
        return (_iterator.getItemIndex(__curItem));
    } // End of the function
    function set selectedIndex(index)
    {
        var _loc2 = _iterator.getItemAt(index);
        if (_loc2 != null)
        {
            __curItem = _loc2;
            _iterator.find(_loc2);
            this.internalDispatchEvent("iteratorScrolled");
        } // end if
        //return (this.selectedIndex());
        null;
    } // End of the function
    function addBinding(aBinding)
    {
        var _loc2 = null;
        if (aBinding.source.component == this)
        {
            _loc2 = aBinding.source;
            if (_loc2.property == "dataProvider")
            {
                Object(aBinding).queueForExecute();
                _loc2.event = "NoEvent";
                _loc2 = null;
            } // end if
        } // end if
        if (aBinding.dest.component == this)
        {
            _loc2 = aBinding.dest;
        } // end if
        if (_loc2 != null)
        {
            var _loc4 = _loc2.property;
            if (_loc4 != "deltaPacket" && _loc4 != "items")
            {
                _loc2.event = new Array("iteratorScrolled", "modelChanged");
            } // end if
        } // end if
        this.super_addBinding(aBinding);
    } // End of the function
    function addEventListener(name, handler)
    {
        _eventDispatcher.addEventListener(name, handler);
    } // End of the function
    function addSort(name, propList, options)
    {
        if (this.hasSort(name))
        {
            throw new mx.data.components.datasetclasses.DataSetError("Sort \'" + name + "\' specified is already added.  Error for dataset \'" + _name + "\'.");
        } // end if
        var _loc4 = null;
        for (var _loc2 = 0; _loc2 < propList.length; ++_loc2)
        {
            _loc4 = __toProperties[propList[_loc2]];
            if (_loc4 == null)
            {
                throw new mx.data.components.datasetclasses.DataSetError("Property \'" + propList[_loc2] + "\' not found in schema for DataSet \'" + _name + "\' can\'t build index.");
            } // end if
            this.addSortInfo(this.getField(_loc4.name), name, _loc2);
        } // end of for
        var _loc6 = new mx.data.components.datasetclasses.DataSetIterator(name, this, _iterators[mx.data.components.DataSet.DefaultIterator]);
        _loc6.setFilterFunc(_filterFunc);
        _loc6.setFiltered(_filtered);
        _loc6.sortOn(propList, options);
        _iterators[name] = _loc6;
        _iterator = _loc6;
        __curItem = _iterator.next();
        this.internalDispatchEvent("modelChanged", {eventName: "sort"});
    } // End of the function
    function addItem(transferObj)
    {
        if (arguments.length > 0 && transferObj == null)
        {
            return (false);
        }
        else
        {
            //return (this.addItemAt(this.length(), transferObj));
        } // end else if
    } // End of the function
    function addItemAt(index, transferObj)
    {
        this.checkReadOnly();
        var _loc5 = true;
        if (transferObj == undefined)
        {
            transferObj = this.createItem(null);
        }
        else
        {
            var _loc7 = transferObj[mx.data.components.DataSet.ItemId];
            _loc5 = _loc7 == undefined || _itemIndexById[_loc7] == undefined;
        } // end else if
        if (_loc5)
        {
            if (this.hasInvalidSchema())
            {
                this.defaultSchema(transferObj);
            } // end if
            var _loc4 = this.internalDispatchEvent("addItem", {item: transferObj, result: true});
            _loc5 = _loc4 == null || _loc4.result;
            if (_loc5 && index <= this.__get__length())
            {
                _loc7 = this.internalAddItem(transferObj, index, true, false);
                if (__logChanges)
                {
                    this.logAddItem(transferObj, false);
                } // end if
                _loc4 = {eventName: "addItems", firstItem: index, lastItem: index};
                this.resyncIterators(_loc4);
                var _loc6 = _iterator.find({__ID__: _loc7});
                if (_loc6 != null)
                {
                    __curItem = _loc6;
                } // end if
                this.internalDispatchEvent("modelChanged", _loc4);
                if (_enableEvents < 0 && _event != null)
                {
                    _event.data.lastItem = index;
                } // end if
            } // end if
        } // end if
        return (_loc5);
    } // End of the function
    function applyUpdates()
    {
        if (_hasDelta > 0)
        {
            var _loc2 = this.getDPTransId();
            var _loc4 = 0;
            if (_dpTransIdCount == 0)
            {
                _lastTransId = _loc2;
            }
            else
            {
                _loc4 = _dpIndexByTransId[_lastTransId].index;
            } // end else if
            _dpIndexByTransId[_loc2] = {index: _deltaItems.length, prevId: _lastTransId, items: _optDeltaItems};
            ++_dpTransIdCount;
            _deltaPacket = new mx.data.components.datasetclasses.DeltaPacketImpl(this, _loc2, this.getKeyInfo(), false, _srcSchema);
            for (var _loc3 in _optDeltaItems)
            {
                _deltaPacket.addItem(_optDeltaItems[_loc3]);
            } // end of for...in
            _lastTransId = _loc2;
            _optDeltaItems = new Array();
            _hasDelta = 0;
            this.internalDispatchEvent("deltaPacketChanged");
        }
        else
        {
            _deltaPacket = null;
        } // end else if
    } // End of the function
    function clear()
    {
        var _loc4 = new Array();
        var _loc5 = new Array();
        var _loc2;
        var _loc6;
        var _loc8 = _iterator.getLength();
        for (var _loc3 = 0; _loc3 < __items.length; ++_loc3)
        {
            _loc2 = __items[_loc3];
            _loc6 = _loc2[mx.data.components.DataSet.ItemId];
            if (_iterator.contains(_loc2))
            {
                if (__logChanges)
                {
                    this.logRemoveItem(_loc2, false);
                } // end if
                _loc5.push(_loc2[mx.data.components.DataSet.ItemId]);
                continue;
            } // end if
            _loc4.push(_loc2);
        } // end of for
        __items = _loc4;
        this.rebuildItemIndexById();
        var _loc7 = {eventName: "removeItems", firstItem: 0, lastItem: _loc8, removedIDs: _loc5};
        this.resyncIterators(_loc7);
        __curItem = this.getCurrentItem();
        delete _loc7[items];
        this.internalDispatchEvent("modelChanged", _loc7);
    } // End of the function
    function createItem(itemData)
    {
        this.checkSchema();
        var _loc5 = null;
        if (_itemClass == null)
        {
            if (__itemClassName.length > 0)
            {
                _itemClass = mx.utils.ClassFinder.findClass(__itemClassName);
                if (_itemClass == null)
                {
                    throw new mx.data.components.datasetclasses.DataSetError("Item class \'" + __itemClassName + "\' specified not found. Error for DataSet \'" + _name + "\'.");
                } // end if
            }
            else
            {
                _itemClass = Function(Object);
            } // end if
        } // end else if
        if (itemData == null)
        {
            _propCage = new Object();
            _trapProperties = true;
            try
            {
                var _loc2;
                for (var _loc3 in __toProperties)
                {
                    _loc2 = _defValues[_loc3];
                    if (_loc2 != null)
                    {
                        this.getField(_loc3).setTypedValue(new mx.data.binding.TypedValue(_loc2, "String"));
                    } // end if
                } // end of for...in
                itemData = _propCage;
            } // End of try
            finally
            {
                _trapProperties = false;
            } // End of finally
        } // end if
        if (_itemClass == Object)
        {
            _loc5 = itemData;
        }
        else
        {
            _loc5 = new this._itemClass();
        } // end else if
        _loc5.setPropertyData(itemData);
        this.internalDispatchEvent("newItem", {item: _loc5});
        return (_loc5);
    } // End of the function
    function disableEvents()
    {
        --_enableEvents;
    } // End of the function
    function dispatchEvent(eventObj)
    {
        this.internalDispatchEvent(eventObj.type, eventObj);
    } // End of the function
    function enableEvents()
    {
        if (_enableEvents < 0)
        {
            ++_enableEvents;
        } // end if
        if (_enableEvents == 0)
        {
            this.internalDispatchEvent(_event.type, _event.data);
            _event = null;
        } // end if
    } // End of the function
    function find(values)
    {
        var _loc2 = _iterator.find(this.convertToRaw(values));
        if (_loc2 != null)
        {
            __curItem = _loc2;
            this.internalDispatchEvent("iteratorScrolled");
        } // end if
        return (_loc2 != null);
    } // End of the function
    function findFirst(values)
    {
        var _loc2 = _iterator.findFirst(this.convertToRaw(values));
        if (_loc2 != null)
        {
            __curItem = _loc2;
            this.internalDispatchEvent("iteratorScrolled");
        } // end if
        return (_loc2 != null);
    } // End of the function
    function findLast(values)
    {
        var _loc2 = _iterator.findLast(this.convertToRaw(values));
        if (_loc2 != null)
        {
            __curItem = _loc2;
            this.internalDispatchEvent("iteratorScrolled");
        } // end if
        return (_loc2 != null);
    } // End of the function
    function first()
    {
        var _loc2 = this.internalFirst();
        if (__curItem != _loc2)
        {
            __curItem = _loc2;
            this.internalDispatchEvent("iteratorScrolled");
        } // end if
    } // End of the function
    function getItemId(index)
    {
        var _loc2 = "";
        if (this.getLength() > 0)
        {
            _loc2 = index == undefined ? (__curItem[mx.data.components.DataSet.ItemId]) : (_iterator.getItemId(index));
        } // end if
        return (_loc2);
    } // End of the function
    function getIterator()
    {
        var _loc3 = this.internalGetId();
        var _loc2 = new mx.data.components.datasetclasses.DataSetIterator(_loc3, this, (mx.data.components.datasetclasses.DataSetIterator)(_iterator));
        _loc2.first();
        _iterators[_loc3] = _loc2;
        return (_loc2);
    } // End of the function
    function getLength()
    {
        return (_iterator.getLength());
    } // End of the function
    function hasNext()
    {
        return (_iterator.getLength() > 0 && (_iterator.hasNext() || _iterator.getCurrentItem() != null));
    } // End of the function
    function hasPrevious()
    {
        return (_iterator.getLength() > 0 && (_iterator.hasPrevious() || _iterator.getCurrentItem() != null));
    } // End of the function
    function hasSort(name)
    {
        return (_iterators[name] != undefined);
    } // End of the function
    function isEmpty()
    {
        //return (this.length() == 0);
    } // End of the function
    function clearDelta(id)
    {
        return (this.removeDelta(_optDeltaItems[id]));
    } // End of the function
    function changesPending()
    {
        return (_hasDelta > 0);
    } // End of the function
    function locateById(id)
    {
        var _loc2 = _iterator.find({__ID__: id});
        if (_loc2 != null)
        {
            __curItem = _loc2;
            this.internalDispatchEvent("iteratorScrolled");
        } // end if
        return (_loc2 != null);
    } // End of the function
    function last()
    {
        _iterator.last();
        var _loc2 = _iterator.previous();
        _iterator.next();
        if (__curItem != _loc2)
        {
            __curItem = _loc2;
            this.internalDispatchEvent("iteratorScrolled");
        } // end if
    } // End of the function
    function loadFromSharedObj(objName, localPath)
    {
        var _loc7 = SharedObject.getLocal(objName, localPath);
        if (_loc7.data.items != undefined)
        {
            this.__set__items(_loc7.data.items);
            var _loc4 = _loc7.data.optDelta;
            _optDeltaItems = new Array();
            var _loc2;
            for (var _loc8 in _loc4)
            {
                _loc2 = _loc4[_loc8];
                _optDeltaItems[_loc2._id] = this.createDelta(_loc2);
            } // end of for...in
            _loc4 = _loc7.data.delta;
            _deltaItems = new Array();
            for (var _loc8 = 0; _loc8 < _loc4.length; ++_loc8)
            {
                _loc2 = _loc4[_loc8];
                if (_optDeltaItems[_loc2._id] == undefined)
                {
                    d = this.createDelta(_loc2);
                }
                else
                {
                    d = _optDeltaItems[_loc2._id];
                } // end else if
                _deltaItems.push(d);
            } // end of for
            var _loc5 = _loc7.data.dpIndex;
            var _loc3;
            for (var _loc8 in _loc5)
            {
                _loc3 = _loc5[_loc8].items;
                for (var _loc6 in _loc3)
                {
                    _loc3[_loc6] = this.findDelta(_loc6);
                } // end of for...in
            } // end of for...in
            _dpIndexByTransId = _loc5;
            _lastTransId = _loc7.data.lastTransId;
            _dpTransIdCount = _loc7.data.transIdCount;
            _hasDelta = _loc7.data.hasDelta;
        } // end if
    } // End of the function
    function next()
    {
        var _loc2 = _iterator.next();
        if (_loc2 != null)
        {
            if (_loc2 == __curItem)
            {
                _loc2 = _iterator.next();
            } // end if
            if (_loc2 != null)
            {
                __curItem = _loc2;
                this.internalDispatchEvent("iteratorScrolled");
            } // end if
        } // end if
    } // End of the function
    function previous()
    {
        var _loc2 = _iterator.previous();
        if (_loc2 != null)
        {
            if (_loc2 == __curItem)
            {
                _loc2 = _iterator.previous();
            } // end if
            if (_loc2 != null)
            {
                __curItem = _loc2;
                this.internalDispatchEvent("iteratorScrolled");
            } // end if
        } // end if
    } // End of the function
    function propertyModified(propName, subProp, typeInfo)
    {
        if (propName == "dataProvider" || propName == "items")
        {
            _srcSchema = typeInfo;
        } // end if
    } // End of the function
    function removeAll()
    {
        var _loc3 = __items.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (__logChanges)
            {
                this.logRemoveItem(__items[_loc2], false);
            } // end if
        } // end of for
        __items = new Array();
        _itemIndexById = new Array();
        var _loc4 = {eventName: "removeItems", firstItem: 0, lastItem: _loc3};
        this.resyncIterators(_loc4);
        this.internalDispatchEvent("modelChanged", _loc4);
    } // End of the function
    function removeEventListener(name, handler)
    {
        _eventDispatcher.removeEventListener(name, handler);
    } // End of the function
    function removeItem(item)
    {
        if (arguments.length > 0 && item == null)
        {
            return (false);
        } // end if
        if (item == null)
        {
            item = __curItem;
        } // end if
        var _loc4 = _itemIndexById[item[mx.data.components.DataSet.ItemId]];
        if (_loc4 != undefined)
        {
            return (this.internalRemoveItem(item));
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function removeItemAt(index)
    {
        return (this.internalRemoveItem(_iterator.getItemAt(index)));
    } // End of the function
    function removeRange()
    {
        _iterator.removeRange();
        __curItem = this.internalFirst();
        this.internalDispatchEvent("modelChanged", {eventName: "filterModel"});
    } // End of the function
    function removeSort(name)
    {
        if (_iterators[name] != undefined)
        {
            if (name != mx.data.components.DataSet.DefaultIterator)
            {
                if (_iterator.getId() == name)
                {
                    this.setIterator(_iterators[mx.data.components.DataSet.DefaultIterator]);
                } // end if
                var _loc3 = _iterators[name].getSortInfo();
                for (var _loc2 = 0; _loc2 < _loc3.keyList.length; ++_loc2)
                {
                    this.removeSortInfo(this.getField(_loc3.keyList[_loc2]), name);
                } // end of for
                delete _iterators[name];
            }
            else
            {
                throw new mx.data.components.datasetclasses.DataSetError("The default index can not be removed.  Error on DataSet \'" + _name + "\'.");
            } // end else if
        }
        else
        {
            throw new mx.data.components.datasetclasses.DataSetError("Sort \'" + name + "\' specified does not exist.  Error on DataSet \'" + _name + "\'.");
        } // end else if
    } // End of the function
    function skip(offset)
    {
        var _loc2 = _iterator.skip(offset);
        if (_loc2 == null)
        {
            if (offset > 0)
            {
                _loc2 = _iterator.previous();
            }
            else
            {
                _loc2 = _iterator.next();
            } // end if
        } // end else if
        if (__curItem != _loc2)
        {
            __curItem = _loc2;
            this.internalDispatchEvent("iteratorScrolled");
        } // end if
        return (this);
    } // End of the function
    function saveToSharedObj(objName, localPath)
    {
        var _loc2 = SharedObject.getLocal(objName, localPath);
        if (_loc2 == null)
        {
            throw new mx.data.components.datasetclasses.DataSetError("Couldn\'t access specified shared object. Error for DataSet \'" + _name + "\'.");
        } // end if
        _loc2.data.items = __items;
        _loc2.data.optDelta = _optDeltaItems;
        _loc2.data.delta = _deltaItems;
        _loc2.data.dpIndex = _dpIndexByTransId;
        _loc2.data.lastTransId = _lastTransId;
        _loc2.data.transIdCount = _dpTransIdCount;
        _loc2.data.hasDelta = _hasDelta;
        if (_loc2.flush() == false)
        {
            throw new mx.data.components.datasetclasses.DataSetError("Couldn\'t save shared object not sufficient space or rights. Error for DataSet \'" + _name + "\'.");
        } // end if
    } // End of the function
    function setIterator(newIterator)
    {
        if (_iterators[newIterator.getId()] == undefined)
        {
            throw new mx.data.components.datasetclasses.DataSetError("Can\'t assign foreign iterator \'" + newIterator.getId() + "\' to DataSet \'" + _name + "\'.");
        } // end if
        _iterator = newIterator;
        __curItem = this.getCurrentItem();
        this.internalDispatchEvent("modelChanged", {eventName: "filterModel"});
    } // End of the function
    function setRange(startValues, endValues)
    {
        _iterator.setRange(this.convertToRaw(startValues), this.convertToRaw(endValues));
        __curItem = this.internalFirst();
        this.internalDispatchEvent("modelChanged", {eventName: "filterModel"});
    } // End of the function
    function useSort(sortName, options)
    {
        if (!this.hasSort(sortName))
        {
            throw new mx.data.components.datasetclasses.DataSetError("Sort specified \'" + sortName + "\' does\'nt exist for DataSet \'" + _name + "\'.");
        } // end if
        var _loc2 = _iterators[sortName];
        if (options != undefined)
        {
            _loc2.setSortOptions(options);
        } // end if
        _loc2.setFiltered(_filtered);
        _loc2.setFilterFunc(_filterFunc);
        _iterator = _loc2;
        this.first();
        this.internalDispatchEvent("modelChanged", {eventName: "sort"});
    } // End of the function
    function addProxy()
    {
        var _loc2;
        for (var _loc3 in __toProperties)
        {
            _loc2 = String(_loc3);
            this.addProperty(_loc2, this["get_" + _loc2], this["set_" + _loc2]);
        } // end of for...in
    } // End of the function
    function addSortInfo(fld, name, index)
    {
        if (fld.sortInfo == null)
        {
            fld.sortInfo = new Array();
        } // end if
        fld.sortInfo[name] = index;
    } // End of the function
    function applyResolvePacket(d, resPckt, dpItems)
    {
        var _loc9 = resPckt.length;
        if (d.getMessage().length > 0)
        {
            resPckt.push(Object(d));
        }
        else
        {
            var _loc3 = d.getChangeList();
            var _loc4 = true;
            for (var _loc2 = 0; _loc2 < _loc3.length && _loc4; ++_loc2)
            {
                _loc4 = _loc3[_loc2].message.length == 0;
            } // end of for
            if (_loc2 < _loc3.length)
            {
                resPckt.push(Object(d));
            } // end if
        } // end else if
        var _loc6 = _loc9 != resPckt.length;
        switch (d.getOperation())
        {
            case mx.data.components.datasetclasses.DeltaPacketConsts.Added:
            {
                if (_loc6)
                {
                    this.logAddItem(d.getSource(), true, d.getId());
                }
                else
                {
                    this.updateItem(d);
                } // end else if
                break;
            } 
            case mx.data.components.datasetclasses.DeltaPacketConsts.Removed:
            {
                if (_loc6)
                {
                    this.logRemoveItem(d.getSource(), true, d.getId());
                } // end if
                break;
            } 
            case mx.data.components.datasetclasses.DeltaPacketConsts.Modified:
            {
                if (!_loc6)
                {
                    this.updateItem(d);
                }
                else
                {
                    var _loc7 = dpItems[d.getId()];
                    _optDeltaItems[d.getId()] = _loc7;
                    _deltaItems.push(Object(_loc7));
                    ++_hasDelta;
                } // end else if
                break;
            } 
        } // End of switch
    } // End of the function
    function buildSchema()
    {
        if (this.hasInvalidSchema())
        {
            __schemaXML = new XML("<properties/>");
        }
        else
        {
            var _loc4 = __schema.elements;
            var _loc2;
            var _loc6 = "<properties>";
            for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
            {
                _loc2 = _loc4[_loc3];
                if (this.isValidElement(_loc2))
                {
                    if (_loc2.type.name == "Date" && _loc2.type.encoder == undefined)
                    {
                        _loc2.type.encoder = {className: "mx.data.encoders.DateToNumber"};
                    } // end if
                    _loc6 = _loc6 + ("<property name=\"" + _loc2.name + "\">" + this.getSchemaXML("type", _loc2.type) + "</property>");
                } // end if
            } // end of for
            _loc6 = _loc6 + "</properties>";
            __schemaXML = new XML(_loc6);
        } // end else if
    } // End of the function
    function createDelta(td)
    {
        var _loc10;
        var _loc1;
        var _loc3;
        _loc10 = new mx.data.components.datasetclasses.DeltaImpl(td._id, td._source, td._op, td._message, td._accessCl);
        for (var _loc2 = 0; _loc2 < td._deltaItems.length; ++_loc2)
        {
            _loc1 = td._deltaItems[_loc2];
            if (_loc1.__kind == mx.data.components.datasetclasses.DeltaItem.Property)
            {
                _loc3 = {newValue: _loc1.__newValue, oldValue: _loc1.__oldValue, curValue: _loc1.__curValue, message: _loc1.__message};
            }
            else
            {
                _loc3 = {argList: _loc1.__argList};
            } // end else if
            new mx.data.components.datasetclasses.DeltaItem(_loc1.__kind, _loc1.__name, _loc3, Object(_loc10));
        } // end of for
        return (_loc10);
    } // End of the function
    function checkReadOnly()
    {
        if (__readOnly)
        {
            throw new mx.data.components.datasetclasses.DataSetError("Can\'t modify a read only DataSet.  Error for \'" + Object(this)._name + "\'.");
        } // end if
    } // End of the function
    function checkSchema()
    {
        if (this.hasInvalidSchema())
        {
            throw new mx.data.components.datasetclasses.DataSetError("Schema has not been specified. Can\'t construct item. Error for DataSet \'" + _name + "\'.");
        } // end if
    } // End of the function
    function createProperties()
    {
        this.removeProxy();
        _allowReslv = true;
        _calcFields.__length__ = 0;
        __toProperties = new Object();
        var _loc2;
        for (var _loc3 = 0; _loc3 < __schema.elements.length; ++_loc3)
        {
            _loc2 = __schema.elements[_loc3];
            if (this.isValidElement(_loc2))
            {
                __toProperties[_loc2.name] = _loc2;
                if (_loc2.type.value != null)
                {
                    _defValues[_loc2.name] = _loc2.type.value;
                    _loc2.type.value = null;
                } // end if
                if (this.getField(_loc2.name).kind.isCalculated)
                {
                    _calcFields[_loc2.name] = _loc2;
                    ++_calcFields.__length__;
                } // end if
            } // end if
        } // end of for
        this.addProxy();
        _allowReslv = __items.length > 0;
    } // End of the function
    function convertToRaw(values)
    {
        if (values instanceof Array)
        {
            return (this.convertArrayToRaw(values));
        }
        else
        {
            return (this.convertObjectToRaw(values));
        } // end else if
    } // End of the function
    function convertArrayToRaw(values)
    {
        _trapProperties = true;
        _propCage = new Object();
        try
        {
            var _loc5 = _iterator.getSortInfo();
            var _loc4;
            var _loc6;
            var _loc3;
            for (var _loc2 = 0; _loc2 < _loc5.keyList.length; ++_loc2)
            {
                if (_loc2 < values.length)
                {
                    _loc4 = this.getField(_loc5.keyList[_loc2]);
                    _loc6 = __toProperties[_loc5.keyList[_loc2]].type;
                    _loc3 = values[_loc2];
                    switch (typeof(_loc3))
                    {
                        case "string":
                        {
                            _loc4.setAsString(_loc3);
                            break;
                        } 
                        case "boolean":
                        {
                            _loc4.setAsBoolean(_loc3);
                            break;
                        } 
                        case "number":
                        {
                            _loc4.setAsNumber(_loc3);
                            break;
                        } 
                        case "object":
                        {
                            _loc4.setTypedValue(new mx.data.binding.TypedValue(_loc3, _loc6.name, _loc6));
                            break;
                        } 
                    } // End of switch
                } // end if
            } // end of for
        } // End of try
        finally
        {
            _trapProperties = false;
        } // End of finally
        return (_propCage);
    } // End of the function
    function convertObjectToRaw(values)
    {
        _trapProperties = true;
        _propCage = new Object();
        try
        {
            var _loc6 = _iterator.getSortInfo();
            var _loc4;
            var _loc7;
            var _loc2;
            for (var _loc3 = 0; _loc3 < _loc6.keyList.length; ++_loc3)
            {
                _loc2 = _loc6.keyList[_loc3];
                _loc4 = this.getField(_loc2);
                _loc7 = __toProperties[_loc6.keyList[_loc3]].type;
                switch (typeof(values[_loc2]))
                {
                    case "string":
                    {
                        _loc4.setAsString(values[_loc2]);
                        break;
                    } 
                    case "boolean":
                    {
                        _loc4.setAsBoolean(values[_loc2]);
                        break;
                    } 
                    case "number":
                    {
                        _loc4.setAsNumber(values[_loc2]);
                        break;
                    } 
                    case "object":
                    {
                        _loc4.setTypedValue(new mx.data.binding.TypedValue(values[_loc2], _loc7.name, _loc7));
                        break;
                    } 
                } // End of switch
            } // end of for
        } // End of try
        finally
        {
            _trapProperties = false;
        } // End of finally
        return (_propCage);
    } // End of the function
    function decodeItem(item)
    {
        var _loc2 = new Object();
        var _loc4 = __curItem;
        __curItem = item;
        try
        {
            for (var _loc3 in __toProperties)
            {
                _loc2[_loc3] = this.getField(_loc3).getTypedValue().value;
            } // end of for...in
        } // End of try
        finally
        {
            __curItem = _loc4;
        } // End of finally
        return (_loc2);
    } // End of the function
    function defaultSchema(obj)
    {
        var _loc2;
        var _loc3;
        var _loc4 = "";
        for (var _loc6 in obj)
        {
            _loc2 = typeof(obj[_loc6]);
            if (_loc2 != "function")
            {
                _loc2 = String(_loc2.charAt(0)).toUpperCase() + _loc2.substring(1, _loc2.length);
                if (_loc2 == "Boolean")
                {
                    _loc3 = "Bool";
                }
                else
                {
                    _loc3 = _loc2.substring(0, 3);
                } // end else if
                _loc4 = "<property name=\"" + _loc6 + "\"><type name=\"" + _loc2 + "\" original=\"false\"><validation className=\"mx.data.types." + _loc3 + "\"/></type></property>" + _loc4;
            } // end if
        } // end of for...in
        this.__set__schema(new XML("<properties>" + _loc4 + "</properties>"));
    } // End of the function
    function decodeValue(fieldName, value)
    {
        _fldValObj.__schema = __schema;
        _fldValObj[fieldName] = value;
        return (_fldValObj.getField(fieldName).getTypedValue().value);
    } // End of the function
    function encodeValue(fieldName, value)
    {
        var _loc2 = __toProperties[fieldName].type;
        _fldValObj.__schema = __schema;
        _fldValObj.getField(fieldName).setTypedValue(new mx.data.binding.TypedValue(value, _loc2.name, _loc2));
        return (_fldValObj[fieldName]);
    } // End of the function
    function findDelta(id)
    {
        for (var _loc2 = 0; _loc2 < _deltaItems.length; ++_loc2)
        {
            if (_deltaItems[_loc2]._id == id)
            {
                return (_deltaItems[_loc2]);
            } // end if
        } // end of for
        return (null);
    } // End of the function
    function internalDispatchEvent(type, params)
    {
        var _loc3 = null;
        if (_enableEvents >= 0)
        {
            _loc3 = {type: type, target: this};
            if (params != undefined)
            {
                for (var _loc4 in params)
                {
                    _loc3[_loc4] = params[_loc4];
                } // end of for...in
            } // end if
            _eventDispatcher.dispatchEvent(_loc3);
        }
        else if (_event != null && _event.type == "modelChanged")
        {
            if (type == "modelChanged")
            {
                if (_event.data.eventName != "sort" && _event.data.eventName != "filter")
                {
                    _event.data = params;
                } // end if
            } // end if
        }
        else
        {
            _event = {data: params, type: type};
        } // end else if
        return (_loc3);
    } // End of the function
    function getDataProviderItem(item, desiredTypes)
    {
        var _loc5 = new Object();
        var _loc4;
        var _loc8 = __curItem;
        var _loc3;
        var _loc2;
        try
        {
            __curItem = item;
            for (var _loc7 in __toProperties)
            {
                _loc3 = desiredTypes[_loc7];
                if (_loc3 == null)
                {
                    _loc3 = "String";
                } // end if
                _loc4 = this.getField(_loc7);
                _loc2 = _loc4.getTypedValue(_loc3);
                if (_loc2 == null)
                {
                    _loc2 = _loc4.getTypedValue();
                } // end if
                _loc5[_loc7] = _loc2.value;
            } // end of for...in
        } // End of try
        finally
        {
            __curItem = _loc8;
        } // End of finally
        return (_loc5);
    } // End of the function
    function getEditingData(fieldName, item, desiredTypes)
    {
        var _loc4;
        var _loc5 = __curItem;
        var _loc2;
        try
        {
            __curItem = item;
            _loc2 = desiredTypes[fieldName];
            if (_loc2 == null)
            {
                _loc2 = "String";
            } // end if
            var _loc3 = this.getField(fieldName);
            val = _loc3.getTypedValue(_loc2);
            if (val == null)
            {
                val = _loc3.getTypedValue();
            } // end if
            _loc4 = val.value;
        } // End of try
        finally
        {
            __curItem = _loc5;
        } // End of finally
        return (_loc4);
    } // End of the function
    function getDisplayValue(propName, index)
    {
        var _loc3 = __curItem;
        var _loc2 = "";
        try
        {
            __curItem = __items[index];
            _loc2 = this.getField(propName).getAsString();
        } // End of try
        finally
        {
            __curItem = _loc3;
        } // End of finally
        return (_loc2);
    } // End of the function
    function getCurrentItem()
    {
        var _loc2 = _iterator.getCurrentItem();
        if (_loc2 == null)
        {
            if (_iterator.hasNext())
            {
                _loc2 = _iterator.next();
                _iterator.previous();
            }
            else
            {
                _loc2 = _iterator.previous();
                _iterator.next();
            } // end if
        } // end else if
        return (_loc2);
    } // End of the function
    function getInternalIndex(index)
    {
        var _loc2 = _iterator.getItemAt(index);
        if (_loc2 == null)
        {
            return (-1);
        } // end if
        return (_itemIndexById[_loc2[mx.data.components.DataSet.ItemId]]);
    } // End of the function
    function getKeyInfo()
    {
        var _loc3;
        var _loc2;
        for (var _loc5 in _iterators)
        {
            _loc3 = _iterators[_loc5];
            _loc2 = _loc3.getSortInfo();
            if (_loc5 != mx.data.components.DataSet.DefaultIterator && (_loc2.options & mx.data.components.datasetclasses.DataSetIterator.Unique) == mx.data.components.datasetclasses.DataSetIterator.Unique)
            {
                return ({options: _loc2.options, keyList: _loc2.keyList.slice(0)});
            } // end if
        } // end of for...in
        var _loc4 = new Array();
        for (var _loc5 in __toProperties)
        {
            _loc4.push(_loc5);
        } // end of for...in
        return ({options: mx.data.components.datasetclasses.DataSetIterator.Unique, keyList: _loc4});
    } // End of the function
    function getModDeltaInfo(id)
    {
        var _loc3 = null;
        var _loc5 = null;
        var _loc6 = _optDeltaItems[id];
        if (_loc6 == undefined)
        {
            _loc3 = __curItem;
            if (_loc3.clone == undefined)
            {
                var _loc8 = _loc3.getPropertyData();
                if (_loc8 != null)
                {
                    _loc5 = this.createItem(_loc8);
                }
                else
                {
                    _loc5 = new Object();
                } // end else if
            }
            else
            {
                _loc5 = _loc3.clone();
            } // end else if
            var _loc2;
            var _loc4;
            for (var _loc7 in _loc3)
            {
                _loc2 = _loc3[_loc7];
                if (typeof(_loc2) != "function")
                {
                    _loc4 = __toProperties[_loc7];
                    _loc5[_loc7] = _loc4 == undefined ? (_loc2) : (this.getField(_loc7).getTypedValue().value);
                } // end if
            } // end of for...in
            _loc6 = new mx.data.components.datasetclasses.DeltaImpl(id, _loc5, mx.data.components.datasetclasses.DeltaPacketConsts.Modified);
            _optDeltaItems[id] = _loc6;
            ++_hasDelta;
            _deltaItems.push(_loc6);
        } // end if
        return (_loc6);
    } // End of the function
    function getPropertyValue(name)
    {
        return (__curItem[name]);
    } // End of the function
    function getResolverFieldList()
    {
        var _loc2 = new Object();
        for (var _loc3 in __toProperties)
        {
            if (_calcFields[_loc3] == null && __toProperties[_loc3].type.path == null)
            {
                _loc2[_loc3] = __toProperties[_loc3];
            } // end if
        } // end of for...in
        return (_loc2);
    } // End of the function
    function getDPTransId()
    {
        return (this.internalGetId() + ":" + new Date().toString());
    } // End of the function
    function getSchemaObject(xmlInfo)
    {
        var _loc3 = new Object();
        var _loc5;
        for (var _loc2 in xmlInfo.attributes)
        {
            _loc5 = xmlInfo.attributes[_loc2];
            if (_loc2 == "original")
            {
                _loc3[_loc2] = _loc5 == "false" ? (false) : (true);
                continue;
            } // end if
            _loc3[_loc2] = _loc5;
        } // end of for...in
        var _loc4 = xmlInfo.childNodes;
        var _loc7;
        for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
        {
            _loc3[_loc4[_loc2].nodeName] = this.getSchemaObject(_loc4[_loc2]);
        } // end of for
        return (_loc3);
    } // End of the function
    function getSchemaXML(nodeName, info)
    {
        var _loc5 = "";
        var _loc2;
        for (var _loc6 in info)
        {
            _loc2 = info[_loc6];
            if (typeof(_loc2) != "object" && _loc6 != "cls")
            {
                _loc5 = _loc5 + (" " + _loc6 + "=\"" + _loc2 + "\"");
            } // end if
        } // end of for...in
        var _loc4 = "<" + nodeName + _loc5 + ">";
        for (var _loc6 in info)
        {
            _loc2 = info[_loc6];
            if (typeof(_loc2) == "object")
            {
                _loc4 = _loc4 + this.getSchemaXML(_loc6, _loc2);
            } // end if
        } // end of for...in
        _loc4 = _loc4 + ("</" + nodeName + ">");
        return (_loc4);
    } // End of the function
    function hasInvalidSchema()
    {
        if (_invalidSchema == undefined)
        {
            _invalidSchema = true;
            if (__schema.elements != null)
            {
                var _loc2 = __schema.elements;
                for (var _loc3 in _loc2)
                {
                    if (_loc2[_loc3].type.original == false)
                    {
                        _invalidSchema = false;
                        return (_invalidSchema);
                    } // end if
                } // end of for...in
            } // end if
        } // end if
        return (_invalidSchema);
    } // End of the function
    function initCollection()
    {
        __items = new Array();
        _itemIndexById = new Array();
        this.internalClearDeltaPacket();
    } // End of the function
    function internalAddItem(item, index, rebuildIndx, pipeData)
    {
        var _loc7;
        if (item[mx.data.components.DataSet.ItemId] == null)
        {
            _loc7 = this.internalGetId();
            item[mx.data.components.DataSet.ItemId] = _loc7;
        }
        else
        {
            _loc7 = item[mx.data.components.DataSet.ItemId];
        } // end else if
        if (index >= __items.length)
        {
            __items.push(item);
        }
        else
        {
            __items.splice(index, 0, item);
        } // end else if
        --_enableEvents;
        var _loc8 = _event;
        _trapProperties = true;
        try
        {
            _propCage = item;
            var _loc3;
            for (var _loc6 in __toProperties)
            {
                _loc3 = __toProperties[_loc6];
                if (rebuildIndx && (item[_loc6] == null && _calcFields[_loc6] == null))
                {
                    this.getField(_loc6).setAsString(__toProperties[_loc6].type.value);
                    continue;
                } // end if
                if (item[_loc6] != null && pipeData)
                {
                    this.getField(_loc6).setTypedValue(new mx.data.binding.TypedValue(item[_loc6], _loc3.type.name, _loc3.type));
                } // end if
            } // end of for...in
        } // End of try
        finally
        {
            ++_enableEvents;
            _event = _loc8;
            _trapProperties = false;
        } // End of finally
        if (_calcFields.__length__ > 0)
        {
            __curItem = item;
            _loading = true;
            try
            {
                this.internalDispatchEvent("calcFields");
            } // End of try
            finally
            {
                _loading = false;
            } // End of finally
        } // end if
        _allowReslv = true;
        if (rebuildIndx)
        {
            this.rebuildItemIndexById();
        } // end if
        return (_loc7);
    } // End of the function
    function internalClearDeltaPacket(transId)
    {
        if (transId == undefined || transId.length == 0)
        {
            _optDeltaItems = new Array();
            _deltaItems = new Array();
            _dpIndexByTransId = new Array();
            _lastTransId = "";
            _dpTransIdCount = 0;
            _hasDelta = 0;
        }
        else
        {
            var _loc2 = _dpIndexByTransId[transId];
            if (_loc2 != undefined)
            {
                var _loc6 = _dpIndexByTransId[_loc2.prevId].index;
                _loc6 = _loc6 == _loc2.index ? (0) : (_loc6);
                var _loc5 = _loc2.index - _loc6;
                _deltaItems.splice(_loc6, _loc5);
                var _loc3 = _lastTransId;
                while (_loc3 != transId)
                {
                    _loc2 = _dpIndexByTransId[_loc3];
                    _loc3 = _loc2.prevId;
                    _loc2.index = _loc2.index - _loc5;
                } // end while
                delete _dpIndexByTransId[transId];
                --_dpTransIdCount;
                if (_dpTransIdCount == 0)
                {
                    _lastTransId = "";
                } // end if
            } // end if
        } // end else if
    } // End of the function
    function internalGetId()
    {
        return ("IID" + String(Math.round(Math.random() * 100000000000.000000)));
    } // End of the function
    function internalFirst()
    {
        _iterator.first();
        var _loc2 = _iterator.next();
        _iterator.previous();
        return (_loc2);
    } // End of the function
    function internalRemoveItem(item)
    {
        this.checkReadOnly();
        var _loc2 = _itemIndexById[item[mx.data.components.DataSet.ItemId]];
        var _loc3 = _loc2 != undefined;
        var _loc4 = this.internalDispatchEvent("removeItem", {result: true, item: item});
        _loc3 = _loc4 == null || _loc4.result;
        if (_loc3)
        {
            __items.splice(_loc2, 1);
            this.rebuildItemIndexById();
            if (__logChanges)
            {
                this.logRemoveItem(item, false);
            } // end if
            _loc4 = {eventName: "removeItems", firstItem: _loc2, lastItem: _loc2, removedIDs: new Array(item[mx.data.components.DataSet.ItemId])};
            this.resyncIterators(_loc4);
            _allowReslv = __items.length > 0;
            __curItem = this.getCurrentItem();
            this.internalDispatchEvent("modelChanged", _loc4);
            if (_enableEvents < 0 && _event != null)
            {
                _event.data.lastItem = _loc2;
            } // end if
        } // end if
        return (_loc3);
    } // End of the function
    function initIterators()
    {
        var _loc2 = null;
        if (_iterators != undefined)
        {
            _loc2 = _iterators[mx.data.components.DataSet.DefaultIterator].getFilterFunc();
        } // end if
        _iterators = new Array();
        _iterator = new mx.data.components.datasetclasses.DataSetIterator(mx.data.components.DataSet.DefaultIterator, this);
        _iterator.setFilterFunc(_loc2);
        _iterators[mx.data.components.DataSet.DefaultIterator] = _iterator;
        _iterator.first();
        __curItem = _iterator.next();
    } // End of the function
    function isValidElement(el)
    {
        return (el.type.original == false);
    } // End of the function
    function logAddItem(item, piped, id)
    {
        if (id == undefined)
        {
            id = item[mx.data.components.DataSet.ItemId];
        } // end if
        var _loc2 = new mx.data.components.datasetclasses.DeltaImpl(id, piped ? (item) : (this.decodeItem(item)), mx.data.components.datasetclasses.DeltaPacketConsts.Added);
        _optDeltaItems[id] = _loc2;
        _deltaItems.push(Object(_loc2));
        ++_hasDelta;
    } // End of the function
    function logRemoveItem(item, piped, id)
    {
        if (id == undefined)
        {
            id = item[mx.data.components.DataSet.ItemId];
        } // end if
        var _loc3 = _optDeltaItems[id];
        item = piped ? (item) : (this.decodeItem(item));
        var _loc6 = _loc3 == undefined ? (item) : (_loc3.getSource());
        var _loc5 = new mx.data.components.datasetclasses.DeltaImpl(id, _loc6, mx.data.components.datasetclasses.DeltaPacketConsts.Removed);
        _deltaItems.push(Object(_loc5));
        if (_loc3 != undefined && _loc3.getOperation() == mx.data.components.datasetclasses.DeltaPacketConsts.Added)
        {
            delete _optDeltaItems[id];
            --_hasDelta;
        }
        else
        {
            delete _optDeltaItems[id];
            _optDeltaItems[id] = _loc5;
            ++_hasDelta;
        } // end else if
    } // End of the function
    function rebuildItemIndexById()
    {
        _itemIndexById = new Array();
        var _loc3;
        for (var _loc2 = 0; _loc2 < __items.length; ++_loc2)
        {
            _loc3 = __items[_loc2];
            _itemIndexById[_loc3[mx.data.components.DataSet.ItemId]] = _loc2;
        } // end of for
    } // End of the function
    function removeProxy()
    {
        var _loc2;
        for (var _loc3 in __toProperties)
        {
            _loc2 = __toProperties[_loc3];
            delete this[_loc2];
            delete this["get_" + _loc2];
            delete this["set_" + _loc2];
        } // end of for...in
    } // End of the function
    function resyncIterators(info)
    {
        for (var _loc3 in _iterators)
        {
            _iterators[_loc3].modelChanged(info);
        } // end of for...in
    } // End of the function
    function setPropertyValue(name, value)
    {
        if (_trapProperties)
        {
            _propCage[name] = value;
        }
        else
        {
            if (_calcFields[name] != undefined)
            {
                __curItem[name] = value;
            }
            else
            {
                this.checkReadOnly();
                var _loc7 = __curItem[name];
                if (_loc7 != value)
                {
                    if (__logChanges)
                    {
                        var _loc6 = this.getModDeltaInfo(__curItem[mx.data.components.DataSet.ItemId]);
                        __curItem[name] = value;
                        if (_loc6.getOperation() == mx.data.components.datasetclasses.DeltaPacketConsts.Modified)
                        {
                            var _loc9 = _loc6.getItemByName(name);
                            if (_loc9 != null)
                            {
                                _loc7 = this.encodeValue(name, _loc9.__get__oldValue());
                            } // end if
                            if (_loc7 != value)
                            {
                                new mx.data.components.datasetclasses.DeltaItem(mx.data.components.datasetclasses.DeltaItem.Property, name, {oldValue: this.decodeValue(name, _loc7), newValue: this.decodeValue(name, value), message: ""}, Object(_loc6));
                            }
                            else if (_loc6.getChangeList().length == 1)
                            {
                                this.removeDelta(_loc6);
                            } // end else if
                        }
                        else
                        {
                            _loc6.getSource()[name] = this.decodeValue(name, value);
                        } // end if
                    } // end else if
                    __curItem[name] = value;
                } // end if
                if (_calcFields.__length__ > 0)
                {
                    this.internalDispatchEvent("calcFields");
                } // end if
            } // end else if
            if (!_loading)
            {
                var _loc10 = _itemIndexById[__curItem[mx.data.components.DataSet.ItemId]];
                var _loc4 = {eventName: "updateField", fieldName: name, firstItem: _loc10, lastItem: _loc10};
                var _loc2 = false;
                for (var _loc8 in _iterators)
                {
                    _loc2 = _iterators[_loc8].modelChanged(_loc4) || _loc2;
                } // end of for...in
                if (_loc2)
                {
                    this.internalDispatchEvent("modelChanged", {eventName: "sort"});
                }
                else
                {
                    this.internalDispatchEvent("modelChanged", _loc4);
                } // end if
            } // end else if
        } // end else if
    } // End of the function
    function removeSortInfo(fld, name)
    {
        if (fld.sortInfo != null)
        {
            delete fld.sortInfo[name];
        } // end if
    } // End of the function
    function removeDelta(d)
    {
        var _loc3 = false;
        for (var _loc2 = 0; !_loc3 && _loc2 < _deltaItems.length; ++_loc2)
        {
            _loc3 = _deltaItems[_loc2] == d;
        } // end of for
        if (_loc3)
        {
            _deltaItems.splice(--_loc2, 1);
            delete _optDeltaItems[d.getId()];
            --_hasDelta;
        } // end if
        return (_loc3);
    } // End of the function
    function __resolve(methodName)
    {
        var _loc3 = null;
        if (_allowReslv)
        {
            var propName = methodName.substring(4);
            if (methodName.substr(0, 4) == "get_")
            {
                _loc3 = function ()
                {
                    return (this.getPropertyValue(propName));
                };
            }
            else if (methodName.substr(0, 4) == "set_")
            {
                _loc3 = function ()
                {
                    this.setPropertyValue(propName, arguments[0]);
                };
            }
            else
            {
                arguments.shift();
                _loc3 = function ()
                {
                    __curItem[methodName].apply(__curItem, arguments);
                    var _loc3 = __curItem[mx.data.components.DataSet.ItemId];
                    if (__logChanges)
                    {
                        var _loc5 = this.getModDeltaInfo(_loc3);
                        new mx.data.components.datasetclasses.DeltaItem(mx.data.components.datasetclasses.DeltaItem.Method, methodName, {argList: arguments, message: ""}, Object(_loc5));
                    } // end if
                    var _loc4 = _itemIndexById[_loc3];
                    this.internalDispatchEvent("modelChanged", {eventName: "updateItems", firstItem: _loc4, lastItem: _loc4});
                };
            } // end else if
        } // end else if
        return (_loc3);
    } // End of the function
    function updateItem(d)
    {
        var _loc8 = d.getId();
        var _loc10;
        var _loc6 = null;
        var _loc12 = __logChanges;
        __logChanges = false;
        try
        {
            if (_loc8 == null)
            {
                _loc10 = d.getSource();
            }
            else
            {
                _loc10 = {__ID__: _loc8};
            } // end else if
            _loc6 = _iterator.find(_loc10);
            if (_loc6 != null)
            {
                var _loc9 = _itemIndexById[_loc6[mx.data.components.DataSet.ItemId]];
                var _loc5 = d.getChangeList();
                var _loc3;
                var _loc11 = __curItem;
                try
                {
                    __curItem = _loc6;
                    for (var _loc4 = 0; _loc4 < _loc5.length; ++_loc4)
                    {
                        _loc3 = (mx.data.components.datasetclasses.DeltaItem)(_loc5[_loc4]);
                        this.getField(_loc3.name).setTypedValue(new mx.data.binding.TypedValue(_loc3.curValue, __toProperties[_loc3.name].type.name, __toProperties[_loc3.name].type));
                    } // end of for
                } // End of try
                finally
                {
                    __curItem = _loc11;
                } // End of finally
                this.internalDispatchEvent("modelChanged", {eventName: "updateItems", firstIndex: _loc9, lastIndex: _loc9});
            }
            else
            {
                _global.__dataLogger.logData(null, "Couldn\'t find the following item:", d.getSource());
            } // end else if
        } // End of try
        finally
        {
            __logChanges = _loc12;
        } // End of finally
    } // End of the function
    static var DefaultIterator = "__default__";
    static var ItemId = "__ID__";
    var _allowReslv = false;
} // End of Class
