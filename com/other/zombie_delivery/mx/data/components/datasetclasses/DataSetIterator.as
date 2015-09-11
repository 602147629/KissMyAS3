class mx.data.components.datasetclasses.DataSetIterator extends Object implements mx.data.to.ValueListIterator
{
    var _id, _dataset, __filtered, __filterFunc, _options, _startBuff, _endBuff, _rangeOn, _curItemIndex, _hasPrev, _hasNext, _cloned, _bof, _eof, _index, _indexById, _keyList;
    function DataSetIterator(id, aDataSet, source)
    {
        super();
        _id = id;
        _dataset = aDataSet;
        if (source == undefined)
        {
            this.reset();
        }
        else
        {
            __filtered = source.__filtered;
            __filterFunc = source.__filterFunc;
            _options = source._options;
            _startBuff = source._startBuff;
            _endBuff = source._endBuff;
            _rangeOn = source._rangeOn;
            _curItemIndex = source._curItemIndex;
            _hasPrev = source._hasPrev;
            _hasNext = source._hasNext;
            _cloned = true;
            _bof = source._bof;
            _eof = source._eof;
            _index = source._index;
            _indexById = source._indexById;
            _keyList = source._keyList;
        } // end else if
    } // End of the function
    function contains(item)
    {
        var _loc2 = _indexById[item[mx.data.components.datasetclasses.DataSetIterator.ItemId]];
        if (_rangeOn)
        {
            return (_loc2 != undefined && (_loc2 <= _eof && _loc2 >= _bof));
        }
        else
        {
            return (_loc2 != undefined);
        } // end else if
    } // End of the function
    function first()
    {
        return (this.resync(_bof - 1));
    } // End of the function
    function find(propValues)
    {
        var _loc2 = this.findObject(propValues, mx.data.components.datasetclasses.DataSetIterator.FindIndexId);
        if (_loc2 < 0)
        {
            return (null);
        }
        else
        {
            _curItemIndex = _loc2;
            return (_index[_loc2]);
        } // end else if
    } // End of the function
    function findFirst(propValues)
    {
        var _loc2 = this.findObject(propValues, mx.data.components.datasetclasses.DataSetIterator.FindFirstIndexId);
        if (_loc2 < 0)
        {
            return (null);
        }
        else
        {
            _curItemIndex = _loc2;
            return (_index[_loc2]);
        } // end else if
    } // End of the function
    function findLast(propValues)
    {
        var _loc2 = this.findObject(propValues, mx.data.components.datasetclasses.DataSetIterator.FindLastIndexId);
        if (_loc2 < 0)
        {
            return (null);
        }
        else
        {
            _curItemIndex = _loc2;
            return (_index[_loc2]);
        } // end else if
    } // End of the function
    function getCurrentItem()
    {
        return (this.resync(_curItemIndex));
    } // End of the function
    function getCurrentItemIndex()
    {
        var _loc2 = _curItemIndex;
        if (_loc2 > _eof)
        {
            _loc2 = _eof;
        } // end if
        if (_loc2 < _bof)
        {
            _loc2 = _bof;
        } // end if
        return (_loc2);
    } // End of the function
    function getFiltered()
    {
        return (__filtered);
    } // End of the function
    function getFilterFunc()
    {
        return (__filterFunc);
    } // End of the function
    function getId()
    {
        return (_id);
    } // End of the function
    function getItemAt(index)
    {
        var _loc2 = index + _bof;
        if (_loc2 <= _eof)
        {
            return (_index[_loc2]);
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
    function getItemId(index)
    {
        return (_index[_bof + index][mx.data.components.datasetclasses.DataSetIterator.ItemId]);
    } // End of the function
    function getItemIndex(item)
    {
        return (_indexById[item[mx.data.components.datasetclasses.DataSetIterator.ItemId]] - _bof);
    } // End of the function
    function getLength()
    {
        if (this.isEmpty())
        {
            return (0);
        }
        else
        {
            return (_eof - _bof + 1);
        } // end else if
    } // End of the function
    function getSortInfo()
    {
        return ({options: _options, keyList: _keyList});
    } // End of the function
    function hasNext()
    {
        return (_hasNext);
    } // End of the function
    function hasPrevious()
    {
        return (_hasPrev);
    } // End of the function
    function isEmpty()
    {
        return (_eof < 0);
    } // End of the function
    function last()
    {
        return (this.resync(_eof + 1));
    } // End of the function
    function modelChanged(eventObj)
    {
        var _loc3 = false;
        if (_options == mx.data.components.datasetclasses.DataSetIterator.Default && !__filtered)
        {
            _index = _dataset.__items;
            _indexById = _dataset._itemIndexById;
            if (eventObj.eventName == "removeItems" && _curItemIndex > _index.length - 1)
            {
                --_curItemIndex;
            } // end if
            _loc3 = eventObj.eventName != "updateField";
        }
        else if (!_cloned)
        {
            var _loc9;
            if (eventObj.eventName == "removeItems")
            {
                var _loc7;
                var _loc6 = eventObj.removedIDs;
                for (var _loc2 = 0; _loc2 < _loc6.length; ++_loc2)
                {
                    _loc7 = _loc6[_loc2];
                    _index.splice(_indexById[_loc7], 1);
                } // end of for
                this.rebuildIndexById();
                _loc3 = true;
            }
            else if (eventObj.eventName == "addItems")
            {
                var _loc8 = _dataset.__items;
                for (var _loc2 = eventObj.firstItem; _loc2 <= eventObj.lastItem; ++_loc2)
                {
                    _loc9 = _loc8[_loc2];
                    var _loc5 = _loc2;
                    if (!__filtered || this.__filterFunc(_loc9))
                    {
                        if (_options != mx.data.components.datasetclasses.DataSetIterator.Default)
                        {
                            _loc5 = this.findObject(_loc9, mx.data.components.datasetclasses.DataSetIterator.FindInsertId);
                        } // end if
                        _index.splice(_loc5, 0, _loc9);
                        this.rebuildIndexById();
                        _loc3 = true;
                    } // end if
                } // end of for
            }
            else if (eventObj.eventName == "updateField")
            {
                for (var _loc2 = 0; _loc2 < _keyList.length && !_loc3; ++_loc2)
                {
                    _loc3 = _keyList[_loc2] == eventObj.fieldName;
                } // end of for
                if (_loc3)
                {
                    _loc9 = _dataset.__items[eventObj.firstItem];
                    _index.splice(_indexById[_loc9[mx.data.components.datasetclasses.DataSetIterator.ItemId]], 1);
                    var _loc10 = this.findObject(_loc9, mx.data.components.datasetclasses.DataSetIterator.FindInsertId);
                    _index.splice(_loc10, 0, _loc9);
                    this.rebuildIndexById();
                } // end else if
            } // end else if
        } // end else if
        if (_loc3)
        {
            this.recalcEndPoints();
        } // end if
        return (_loc3);
    } // End of the function
    function setFiltered(value)
    {
        var _loc2 = 0;
        if (__filtered != value)
        {
            _loc2 = this.internalFilterItems(value);
            __filtered = value;
        } // end if
        return (_loc2);
    } // End of the function
    function setFilterFunc(value)
    {
        var _loc2 = 0;
        __filterFunc = value;
        if (__filterFunc == null && __filtered)
        {
            return (this.internalFilterItems(false));
        } // end if
        if (__filtered)
        {
            this.internalFilterItems(false);
            _loc2 = this.internalFilterItems(true);
        } // end if
        return (_loc2);
    } // End of the function
    function skip(offset)
    {
        return (this.resync(_curItemIndex + offset));
    } // End of the function
    function next()
    {
        return (this.skip(1));
    } // End of the function
    function previous()
    {
        return (this.skip(-1));
    } // End of the function
    function removeRange()
    {
        if (_rangeOn)
        {
            _rangeOn = false;
            this.recalcEndPoints();
        } // end if
    } // End of the function
    function reset()
    {
        __filtered = false;
        __filterFunc = null;
        _options = mx.data.components.datasetclasses.DataSetIterator.Default;
        _startBuff = null;
        _endBuff = null;
        _rangeOn = false;
        _cloned = false;
        _index = _dataset.__items;
        _indexById = _dataset._itemIndexById;
        this.resetEndPoints();
        _curItemIndex = _bof;
        _hasPrev = false;
        _hasNext = _curItemIndex < _eof;
    } // End of the function
    function setRange(startValues, endValues)
    {
        this.checkSort();
        this.resetEndPoints();
        _rangeOn = true;
        _startBuff = startValues;
        _endBuff = endValues;
        this.recalcEndPoints();
    } // End of the function
    function setSortOptions(options)
    {
        if (_options != mx.data.components.datasetclasses.DataSetIterator.Default)
        {
            if ((options & mx.data.components.datasetclasses.DataSetIterator.Ascending) == mx.data.components.datasetclasses.DataSetIterator.Ascending && (_options & mx.data.components.datasetclasses.DataSetIterator.Descending) == mx.data.components.datasetclasses.DataSetIterator.Descending)
            {
                _options = _options ^ mx.data.components.datasetclasses.DataSetIterator.Descending;
            } // end if
            _options = _options | (this.hasNumericKey() ? (Array.NUMERIC) : (0));
            _options = _options | options;
            this.internalSort();
            this.first();
            this.recalcEndPoints();
        } // end if
    } // End of the function
    function sortOn(propList, options)
    {
        _options = options == undefined ? (mx.data.components.datasetclasses.DataSetIterator.Ascending) : (options);
        _keyList = propList;
        _rangeOn = false;
        _options = _options | (this.hasNumericKey() ? (Array.NUMERIC) : (0));
        this.internalSort();
        this.first();
        this.recalcEndPoints();
    } // End of the function
    function checkSort()
    {
        if (_options == mx.data.components.datasetclasses.DataSetIterator.Default)
        {
            throw new mx.data.components.datasetclasses.DataSetError("Operation not applicable when no sort has been defined. Error for iterator \'" + _id + "\'.");
        } // end if
    } // End of the function
    function checkError(a)
    {
        if (typeof(a) == "number")
        {
            throw new mx.data.components.datasetclasses.DataSetError("Sort failed with the following error \'" + mx.utils.ErrorStrings.getPlayerError(a) + "\'");
        } // end if
    } // End of the function
    function compareValues(a, b)
    {
        if (a == null && b == null)
        {
            return (0);
        } // end if
        if (a == null)
        {
            return (1);
        } // end if
        if (b == null)
        {
            return (-1);
        } // end if
        if (a < b)
        {
            return (-1);
        }
        else if (a > b)
        {
            return (1);
        }
        else
        {
            return (0);
        } // end else if
    } // End of the function
    function comparePropList(alist, blist, ci)
    {
        var _loc5;
        var _loc6 = 0;
        var _loc4 = 0;
        var _loc2;
        var _loc3;
        while (_loc6 == 0 && _loc4 < _keyList.length)
        {
            _loc5 = _keyList[_loc4];
            _loc2 = alist[_loc5];
            _loc3 = blist[_loc5];
            if (ci && typeof(_loc2) == "string")
            {
                _loc2 = _loc2.toLowerCase();
                _loc3 = _loc3.toLowerCase();
            } // end if
            _loc6 = this.compareValues(_loc2, _loc3);
            ++_loc4;
        } // end while
        return (_loc6);
    } // End of the function
    function hasNumericKey()
    {
        var _loc3 = _index[0];
        for (var _loc2 = 0; _loc2 < _keyList.length; ++_loc2)
        {
            if (typeof(_loc3[_keyList[_loc2]]) == "number")
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    function filterIndex()
    {
        var _loc7 = new Array();
        var _loc3;
        var _loc4 = false;
        var _loc6 = 0;
        var _loc8;
        var _loc5 = 0;
        _indexById = new Array();
        for (var _loc2 = 0; _loc2 < _index.length; ++_loc2)
        {
            _loc3 = _index[_loc2];
            try
            {
                _loc4 = this.__filterFunc(_loc3);
            } // End of try
            catch ()
            {
                _loc4 = true;
            } // End of catch
            if (_loc4)
            {
                _loc7.push(_loc3);
                _indexById[_loc3[mx.data.components.datasetclasses.DataSetIterator.ItemId]] = _loc5;
                ++_loc5;
                continue;
            } // end if
            --_loc6;
        } // end of for
        _index = _loc7;
        _cloned = false;
        return (_loc6);
    } // End of the function
    function findObject(propInfo, mode)
    {
        var _loc19 = propInfo[mx.data.components.datasetclasses.DataSetIterator.ItemId];
        if (_loc19 != undefined && mode != mx.data.components.datasetclasses.DataSetIterator.FindInsertId)
        {
            var _loc18 = _indexById[_loc19];
            if (_rangeOn && (_loc18 > _eof || _loc18 < _bof))
            {
                _loc18 = -1;
            } // end if
            return (_loc18);
        } // end if
        this.checkSort();
        var _loc3 = false;
        var _loc17 = mode == mx.data.components.datasetclasses.DataSetIterator.FindIndexId || mode == mx.data.components.datasetclasses.DataSetIterator.FindFirstIndexId || mode == mx.data.components.datasetclasses.DataSetIterator.FindLastIndexId;
        var _loc15 = (_options & mx.data.components.datasetclasses.DataSetIterator.Unique) != mx.data.components.datasetclasses.DataSetIterator.Unique;
        var _loc16 = false;
        var _loc2 = 0;
        var _loc6 = _loc17 ? (_bof) : (0);
        var _loc7 = _loc17 ? (_eof) : (_index.length - 1);
        var _loc14 = null;
        var _loc12 = 1;
        var _loc13 = (_options & mx.data.components.datasetclasses.DataSetIterator.Descending) == mx.data.components.datasetclasses.DataSetIterator.Descending;
        var _loc9 = (_options & mx.data.components.datasetclasses.DataSetIterator.CaseInsensitive) == mx.data.components.datasetclasses.DataSetIterator.CaseInsensitive;
        while (!_loc16 && _loc6 <= _loc7)
        {
            _loc2 = Math.round((_loc6 + _loc7) / 2);
            _loc14 = _index[_loc2];
            _loc12 = this.comparePropList(propInfo, _loc14, _loc9);
            switch (_loc12)
            {
                case -1:
                {
                    if (_loc13)
                    {
                        _loc6 = _loc2 + 1;
                    }
                    else
                    {
                        _loc7 = _loc2 - 1;
                    } // end else if
                    break;
                } 
                case 0:
                {
                    _loc16 = true;
                    if (!_loc15 && mode == mx.data.components.datasetclasses.DataSetIterator.FindInsertId)
                    {
                        throw new mx.data.components.datasetclasses.DataSetError("Duplicate key specified. Error for index \'" + _id + "\' on dataset \'" + _dataset._name + "\'.");
                    } // end if
                    if (_loc15 && _loc17)
                    {
                        switch (mode)
                        {
                            case mx.data.components.datasetclasses.DataSetIterator.FindIndexId:
                            {
                                _loc3 = true;
                                break;
                            } 
                            case mx.data.components.datasetclasses.DataSetIterator.FindFirstIndexId:
                            {
                                _loc3 = _loc2 == _loc6;
                                var _loc8 = null;
                                var _loc5 = _loc2 - 1;
                                var _loc4 = true;
                                while (_loc4 && !_loc3 && _loc5 >= _loc6)
                                {
                                    _loc8 = _index[_loc5];
                                    _loc4 = this.comparePropList(propInfo, _loc8, _loc9) == 0;
                                    if (!_loc4 || _loc4 && _loc5 == _loc6)
                                    {
                                        _loc3 = true;
                                        _loc2 = _loc5 + (_loc4 ? (0) : (1));
                                    } // end if
                                    --_loc5;
                                } // end while
                                break;
                            } 
                            case mx.data.components.datasetclasses.DataSetIterator.FindLastIndexId:
                            {
                                _loc3 = _loc2 == _loc7;
                                _loc8 = null;
                                _loc5 = _loc2 + 1;
                                _loc4 = true;
                                while (_loc4 && !_loc3 && _loc5 <= _loc7)
                                {
                                    _loc8 = _index[_loc5];
                                    _loc4 = this.comparePropList(propInfo, _loc8, _loc9) == 0;
                                    if (!_loc4 || _loc4 && _loc5 == _loc7)
                                    {
                                        _loc3 = true;
                                        _loc2 = _loc5 - (_loc4 ? (0) : (1));
                                    } // end if
                                    ++_loc5;
                                } // end while
                                break;
                            } 
                        } // End of switch
                    }
                    else
                    {
                        _loc3 = true;
                    } // end else if
                    break;
                } 
                case 1:
                {
                    if (_loc13)
                    {
                        _loc7 = _loc2 - 1;
                    }
                    else
                    {
                        _loc6 = _loc2 + 1;
                    } // end else if
                    break;
                } 
            } // End of switch
        } // end while
        if (!_loc3 && _loc17)
        {
            return (-1);
        }
        else if (_loc13)
        {
            return (_loc12 < 0 ? (_loc2 + 1) : (_loc2));
        }
        else
        {
            return (_loc12 > 0 ? (_loc2 + 1) : (_loc2));
        } // end else if
    } // End of the function
    function internalFilterItems(value)
    {
        var _loc2 = 0;
        if (value && __filterFunc != null)
        {
            _loc2 = this.filterIndex();
        }
        else
        {
            this.unfilterIndex();
            if (_options != mx.data.components.datasetclasses.DataSetIterator.Default)
            {
                this.internalSort();
            } // end if
            _loc2 = _index.length;
        } // end else if
        this.recalcEndPoints();
        return (_loc2);
    } // End of the function
    function internalSort()
    {
        var _loc5 = (_options & mx.data.components.datasetclasses.DataSetIterator.Ascending) == mx.data.components.datasetclasses.DataSetIterator.Ascending ? (_options ^ mx.data.components.datasetclasses.DataSetIterator.Ascending) : (_options);
        if (_cloned)
        {
            _cloned = false;
            var _loc3 = _index.sortOn(Object(_keyList), _loc5 | Array.RETURNINDEXEDARRAY);
            this.checkError(_loc3);
            var _loc4 = new Array();
            for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
            {
                _loc4.push(_index[_loc3[_loc2]]);
            } // end of for
            _index = _loc4;
        }
        else
        {
            this.checkError(_index.sortOn(Object(_keyList), _loc5));
        } // end else if
        this.rebuildIndexById();
    } // End of the function
    function recalcEndPoints()
    {
        this.resetEndPoints();
        if (_rangeOn)
        {
            _bof = this.findObject(_startBuff, mx.data.components.datasetclasses.DataSetIterator.FindFirstIndexId);
            if (_bof >= 0)
            {
                _eof = this.findObject(_endBuff, mx.data.components.datasetclasses.DataSetIterator.FindLastIndexId);
                if (_eof < 0)
                {
                    _bof = 0;
                } // end if
            }
            else
            {
                _eof = _bof - 1;
            } // end else if
            _curItemIndex = _bof - 1;
        } // end if
        this.resync(_curItemIndex);
    } // End of the function
    function resetEndPoints()
    {
        _eof = _index.length - 1;
        _bof = 0;
    } // End of the function
    function rebuildIndexById()
    {
        _indexById = new Array();
        for (var _loc2 = 0; _loc2 < _index.length; ++_loc2)
        {
            _indexById[_index[_loc2][mx.data.components.datasetclasses.DataSetIterator.ItemId]] = _loc2;
        } // end of for
    } // End of the function
    function resync(newPos)
    {
        if (_eof < _bof)
        {
            _hasNext = false;
            _hasPrev = false;
            _curItemIndex = _eof;
            return (null);
        } // end if
        if (newPos >= _eof)
        {
            _hasNext = false;
            _hasPrev = true;
            if (newPos == _eof)
            {
                _curItemIndex = _eof;
                return (_index[_eof]);
            }
            else
            {
                _curItemIndex = _eof + 1;
                return (null);
            } // end if
        } // end else if
        if (newPos <= _bof)
        {
            _hasPrev = false;
            _hasNext = true;
            if (newPos == _bof)
            {
                _curItemIndex = _bof;
                return (_index[_bof]);
            }
            else
            {
                _curItemIndex = _bof - 1;
                return (null);
            } // end if
        } // end else if
        _curItemIndex = newPos;
        _hasNext = true;
        _hasPrev = true;
        return (_index[_curItemIndex]);
    } // End of the function
    function unfilterIndex()
    {
        _index = _dataset.__items;
        _indexById = _dataset._itemIndexById;
        _cloned = true;
    } // End of the function
    static var Ascending = 32;
    static var CaseInsensitive = Array.CASEINSENSITIVE;
    static var Descending = Array.DESCENDING;
    static var Unique = Array.UNIQUESORT;
    static var Default = 0;
    static var FindInsertId = 0;
    static var FindIndexId = 1;
    static var FindFirstIndexId = 2;
    static var FindLastIndexId = 3;
    static var ItemId = "__ID__";
} // End of Class
