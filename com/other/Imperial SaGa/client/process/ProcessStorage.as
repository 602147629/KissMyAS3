package process
{
    import button.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import network.*;
    import popup.*;
    import resource.*;
    import storage.*;
    import tutorial.*;
    import utility.*;

    public class ProcessStorage extends ProcessBase
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_STORAGE_NOTICE:int = 2;
        private const _PHASE_STORAGE_NOTICE_RECEIVE:int = 3;
        private const _PHASE_MAIN:int = 10;
        private const _PHASE_MAINTENANCE:int = 90;
        private const _PHASE_CLOSE:int = 99;
        private const _BUTTON_ID_CLOSE:int = 100;
        private var _titleMc:MovieClip;
        private var _mainMc:MovieClip;
        private var _baseMc:MovieClip;
        private var _itemListMc:StorageItemList;
        private var _isoMain:InStayOut;
        private var _isoTitle:InStayOut;
        private var _phase:int;
        private var _modeChangeButton:ButtonBase;
        private var _modeChangeButton2:ButtonBase;
        private var _closeButton:ButtonBase;
        private var _bIsConnecting:Boolean;
        private var _bButtonEnable:Boolean;

        public function ProcessStorage()
        {
            return;
        }// end function

        override public function init() : void
        {
            super.init();
            ResourceManager.getInstance().loadResource(ResourcePath.HOME_PATH + "UI_Storage.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Popup.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.ITEM_IMG_PATH + "Item_Gorld.png");
            ResourceManager.getInstance().loadResource(ResourcePath.ITEM_IMG_PATH + "Item_SummonOrb.png");
            ResourceManager.getInstance().loadResource(ResourcePath.ITEM_IMG_PATH + "Item_SpiritStone.png");
            ResourceManager.getInstance().loadResource(ResourcePath.ITEM_IMG_PATH + "Item_AcceDummy.png");
            CommonPopup.getInstance().loadResource();
            this._bIsConnecting = true;
            NetManager.getInstance().request(new NetTaskWareHouseInfo(this.cbReceive));
            _bResourceLoadWait = true;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._itemListMc)
            {
                this._itemListMc.release();
            }
            this._itemListMc = null;
            if (this._closeButton)
            {
                ButtonManager.getInstance().removeButton(this._closeButton);
            }
            this._closeButton = null;
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            super.controlResourceWait();
            if (!ResourceManager.getInstance().isLoaded() || this._bIsConnecting)
            {
                return;
            }
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Storage.swf", "StorageMainMc");
            this.addChild(this._baseMc);
            this._titleMc = this._baseMc.storageTitleMc;
            this._mainMc = this._baseMc.storageMainMc;
            this._isoMain = new InStayOut(this._mainMc, true);
            this._isoTitle = new InStayOut(this._titleMc, true);
            this._itemListMc = new StorageItemList(this._mainMc, this._mainMc.starageListMc);
            this._closeButton = ButtonManager.getInstance().addButton(this._mainMc.returnBtnMc, this.cbCloseButton);
            this._closeButton.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._closeButton.setDisable(true);
            TextControl.setIdText(this._mainMc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            _bResourceLoadWait = false;
            this._bButtonEnable = false;
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_MAIN:
                {
                    this.controlMain();
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                case this._PHASE_MAINTENANCE:
                {
                    this.controlPhaseMaintenance();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._itemListMc)
            {
                this._itemListMc.control(param1);
                if (this._itemListMc.bButtonEnable != this._bButtonEnable)
                {
                    this._bButtonEnable = this._itemListMc.bButtonEnable;
                    this._closeButton.setDisable(!this._bButtonEnable);
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_STORAGE_NOTICE:
                    {
                        this.phaseStorageNotice();
                        break;
                    }
                    case this._PHASE_STORAGE_NOTICE_RECEIVE:
                    {
                        this.phaseStorageNoticeReceive();
                        break;
                    }
                    case this._PHASE_MAIN:
                    {
                        this.phaseMain();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    case this._PHASE_MAINTENANCE:
                    {
                        this.initPhaseMaintenance();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._isoMain.setIn();
            this._isoTitle.setIn();
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_WEARHOUSE))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_WEARHOUSE);
            }
            return;
        }// end function

        private function controlOpen() : void
        {
            if (!this._isoMain.bAnimetion && !this._isoTitle.bAnimetion && !CommonPopup.isUse())
            {
                this.setPhase(this._PHASE_STORAGE_NOTICE);
            }
            return;
        }// end function

        private function phaseStorageNotice() : void
        {
            if (StorageManager.getInstance().isWarehouseGiftDleted())
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, StorageManager.getInstance().getWarehouseGiftDletedText(), this.cbStorageNoticePopup);
            }
            else
            {
                this.setPhase(this._PHASE_MAIN);
            }
            return;
        }// end function

        private function cbStorageNoticePopup() : void
        {
            this.setPhase(this._PHASE_STORAGE_NOTICE_RECEIVE);
            return;
        }// end function

        private function phaseStorageNoticeReceive() : void
        {
            NetManager.getInstance().request(new NetTaskWareHouseNoticeCheck(this.cbStorageNoticeReceive));
            return;
        }// end function

        private function cbStorageNoticeReceive(param1:NetResult) : void
        {
            this.setPhase(this._PHASE_MAIN);
            return;
        }// end function

        private function phaseMain() : void
        {
            _bTopbarButtonDisable = false;
            this._itemListMc.setButtonDisable(false);
            return;
        }// end function

        private function controlMain() : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            _bTopbarButtonDisable = true;
            this._closeButton.setDisable(true);
            this._itemListMc.setButtonDisable(true);
            this._isoMain.setOut();
            this._isoTitle.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            if (!this._isoMain.bAnimetion && !this._isoTitle.bAnimetion)
            {
                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
            }
            return;
        }// end function

        private function initPhaseMaintenance() : void
        {
            if (Main.GetApplicationData().maintenanceData.isMaintenanceTime())
            {
                Main.GetProcess().createMaintenanceWindow();
            }
            else
            {
                this.setPhase(this._PHASE_MAIN);
            }
            return;
        }// end function

        private function controlPhaseMaintenance() : void
        {
            if (Main.GetProcess().maintenance == null)
            {
                this.setPhase(this._PHASE_MAIN);
            }
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

        private function cbReceive(param1:NetResult) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_2 = StorageManager.getInstance().getAllStorageItemId(StorageConstant.ITEM_FILTER_NONE, StorageConstant.STORAGE_KIND_UNLIMITED_ITEM);
            _loc_2 = _loc_2.concat(StorageManager.getInstance().getAllStorageItemId(StorageConstant.ITEM_FILTER_NONE, StorageConstant.STORAGE_KIND_LIMIT_ITEM));
            _loc_2 = _loc_2.concat(StorageManager.getInstance().getAllStorageItemId(StorageConstant.ITEM_FILTER_NONE, StorageConstant.STORAGE_KIND_HISTORY));
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = StorageManager.getInstance().getStorageItem(_loc_3);
                _loc_5 = ItemManager.getInstance().getItemPng(_loc_4.category, _loc_4.itemId);
                if (_loc_5 == "")
                {
                    Assert.print("ファイル名が有りません");
                }
                ResourceManager.getInstance().loadResource(_loc_5);
            }
            this._bIsConnecting = false;
            return;
        }// end function

    }
}
