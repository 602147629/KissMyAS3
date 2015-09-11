class mx.data.components.datasetclasses.DataSetDataProvider extends Object
{
    var _dataset, _dg, _dgInit, _desiredTypes, __get__length;
    function DataSetDataProvider(aDataSet)
    {
        super();
        _dataset = aDataSet;
    } // End of the function
    function get length()
    {
        if (_dg != null && _dgInit != true)
        {
            _dgInit = true;
            var _loc2;
            for (var _loc3 in _dg.columns)
            {
                _loc2 = _dg.columns[_loc3];
                _loc2.editable = _loc2.editable && !this.isFieldReadOnly(_loc2.columnName);
            } // end of for...in
        } // end if
        return (_dataset.length);
    } // End of the function
    function addEventListener(eventName, handler)
    {
        _desiredTypes = handler.getBindingMetaData("acceptedTypes");
        if (handler instanceof mx.controls.DataGrid)
        {
            if (_dataset.readOnly)
            {
                handler.editable = false;
            }
            else
            {
                _dg = handler;
                _dgInit = false;
            } // end if
        } // end else if
        _dataset.addEventListener(eventName, handler);
    } // End of the function
    function addItem(item)
    {
        _dataset.addItem(item);
    } // End of the function
    function addItemAt(index, transferObj)
    {
        _dataset.addItemAt(index, transferObj);
    } // End of the function
    function editField(index, fieldName, newData)
    {
        var _loc3 = _dataset.__curItem;
        try
        {
            _dataset.__curItem = _dataset._iterator.getItemAt(index);
            var _loc2 = _desiredTypes[fieldName];
            if (_loc2 == null)
            {
                _loc2 = "String";
            } // end if
            _dataset.getField(fieldName).setTypedValue(new mx.data.binding.TypedValue(newData, _loc2));
        } // End of try
        finally
        {
            _dataset.__curItem = _loc3;
        } // End of finally
    } // End of the function
    function getColumnNames()
    {
        var _loc2 = new Array();
        for (var _loc3 in _dataset.properties)
        {
            _loc2.push(_loc3);
        } // end of for...in
        _loc2.reverse();
        return (_loc2);
    } // End of the function
    function getEditingData(index, fieldName)
    {
        return (_dataset.getEditingData(fieldName, _dataset._iterator.getItemAt(index), _desiredTypes));
    } // End of the function
    function getItemAt(index)
    {
        if (index >= _dataset.length)
        {
            return (null);
        } // end if
        var _loc2 = _dataset._iterator.getItemAt(index);
        if (_loc2 != null)
        {
            return (_dataset.getDataProviderItem(_loc2, _desiredTypes));
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
    function getItemID(index)
    {
        return (_dataset.getItemId(index));
    } // End of the function
    function removeAll()
    {
        _dataset.removeAll();
    } // End of the function
    function removeItemAt(index)
    {
        _dataset.removeItemAt(index);
    } // End of the function
    function replaceItemAt(index, item)
    {
        this.removeItemAt(index);
        this.addItemAt(index, item);
    } // End of the function
    function sortItemsBy(fieldNames, options)
    {
        var _loc4;
        var _loc3 = 0;
        if (typeof(options) == "string")
        {
            _loc3 = options.toUpperCase() == "DESC" ? (Array.DESCENDING) : (mx.data.components.datasetclasses.DataSetIterator.Ascending);
        }
        else
        {
            _loc3 = options;
        } // end else if
        if (typeof(fieldNames) == "array")
        {
            _loc4 = fieldNames.join("_");
        }
        else
        {
            _loc4 = fieldNames;
            fieldNames = new Array(fieldNames);
        } // end else if
        for (var _loc5 in fieldNames)
        {
            if (_dataset.properties[fieldNames[_loc5]].type.name == "String")
            {
                _loc3 = _loc3 | Array.CASEINSENSITIVE;
                break;
            } // end if
        } // end of for...in
        if (_dataset.hasSort(_loc4))
        {
            _dataset.useSort(_loc4, _loc3);
        }
        else
        {
            _dataset.addSort(_loc4, fieldNames, _loc3);
        } // end else if
    } // End of the function
    function isFieldReadOnly(name)
    {
        return (_dataset.properties[name].type.readonly == true);
    } // End of the function
} // End of Class
