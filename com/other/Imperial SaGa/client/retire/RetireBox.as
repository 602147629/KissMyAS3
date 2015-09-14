package retire
{
    import asset.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class RetireBox extends Object
    {
        private var _mcBase:MovieClip;
        private var _numMcSelected:NumericNumberMc;
        private var _numMcMax:NumericNumberMc;
        private var _isoEffect:InStayOut;
        private var _aRetireDisplay:Array;
        private var _goldInsignia:int;
        private var _silverInsignia:int;
        public static const RETIRE_SELECT_PLAYER_MAX:int = 10;

        public function RetireBox(param1:MovieClip)
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            this._mcBase = param1;
            _loc_2 = ResourceManager.getInstance().createBitmap(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_GOLD_INSIGNIA));
            _loc_2.smoothing = true;
            this._mcBase.GetInsigniaBox.insigniaMc01.itemNull.addChild(_loc_2);
            _loc_2 = ResourceManager.getInstance().createBitmap(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_SILVER_INSIGNIA));
            _loc_2.smoothing = true;
            this._mcBase.GetInsigniaBox.insigniaMc02.itemNull.addChild(_loc_2);
            this._numMcSelected = new NumericNumberMc(this._mcBase.serectCharaNumMc.serectCharaNumMc.serectCharaNum2, 0, 0);
            this._numMcMax = new NumericNumberMc(this._mcBase.serectCharaNumMc.serectCharaNumMc.serectCharaNum1, RETIRE_SELECT_PLAYER_MAX, 0);
            this._isoEffect = new InStayOut(this._mcBase.EffectMc);
            this._aRetireDisplay = [];
            var _loc_3:* = 0;
            while (_loc_3 < RETIRE_SELECT_PLAYER_MAX)
            {
                
                _loc_4 = this._mcBase["SelectCharaNull" + (1 + _loc_3)];
                this._aRetireDisplay.push(new RetirePlayerDisplay(_loc_4));
                _loc_3++;
            }
            TextControl.setIdText(this._mcBase.GetInsigniaBox.textMc.textDt, MessageId.RETIREMENT_GET_INSIGNIA_HEADLINE);
            TextControl.setIdText(this._mcBase.serectCharaNumMc.textMc.textDt, MessageId.FACILITY_SELECTED_PLAYER_TEXT);
            TextControl.setIdText(this._mcBase.serectCharaNumMc.unitMc.textDt, MessageId.FACILITY_SELECTED_PLAYER_UNIT);
            this.setSelectedPlayer([]);
            return;
        }// end function

        public function get bStay() : Boolean
        {
            return this._isoEffect && this._isoEffect.bAnimetion == false;
        }// end function

        public function get goldInsignia() : int
        {
            return this._goldInsignia;
        }// end function

        public function get silverInsignia() : int
        {
            return this._silverInsignia;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aRetireDisplay)
            {
                
                _loc_1.release();
            }
            this._aRetireDisplay = null;
            if (this._isoEffect)
            {
                this._isoEffect.release();
            }
            this._isoEffect = null;
            if (this._numMcMax)
            {
                this._numMcMax.release();
            }
            this._numMcMax = null;
            if (this._numMcSelected)
            {
                this._numMcSelected.release();
            }
            this._numMcSelected = null;
            this._mcBase = null;
            return;
        }// end function

        public function setSelectedPlayer(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aRetireDisplay.length)
            {
                
                _loc_3 = this._aRetireDisplay[_loc_2];
                if (_loc_2 < param1.length)
                {
                    _loc_3.setPlayer(param1[_loc_2].info.id, param1[_loc_2].uniqueId, param1[_loc_2].info.rarity);
                }
                else
                {
                    _loc_3.reset();
                }
                _loc_2++;
            }
            this.update();
            return;
        }// end function

        public function effectStart() : void
        {
            var _loc_1:* = null;
            this._isoEffect.setIn();
            SoundManager.getInstance().playSe(SoundId.SE_EFFECT);
            for each (_loc_1 in this._aRetireDisplay)
            {
                
                _loc_1.play();
            }
            return;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = null;
            this._isoEffect.setEnd();
            for each (_loc_1 in this._aRetireDisplay)
            {
                
                _loc_1.reset();
            }
            this.update();
            return;
        }// end function

        private function update() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = [];
            var _loc_2:* = 0;
            while (_loc_2 < this._aRetireDisplay.length)
            {
                
                _loc_3 = this._aRetireDisplay[_loc_2];
                if (_loc_3.uniqueId == Constant.EMPTY_ID)
                {
                    break;
                }
                _loc_1.push(_loc_3.uniqueId);
                _loc_2++;
            }
            this._numMcSelected.setNum(_loc_1.length);
            this._goldInsignia = RetireUtility.calcGoldInsigniaNum(_loc_1);
            this._silverInsignia = RetireUtility.calcSilverInsigniaNum(_loc_1);
            TextControl.setText(this._mcBase.GetInsigniaBox.insigniaMc01.textMc.textDt, this._goldInsignia.toString());
            TextControl.setText(this._mcBase.GetInsigniaBox.insigniaMc02.textMc.textDt, this._silverInsignia.toString());
            return;
        }// end function

    }
}
