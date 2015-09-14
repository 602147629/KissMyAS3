package tradingPost
{
    import asset.*;
    import flash.display.*;
    import icon.*;
    import message.*;
    import resource.*;
    import user.*;
    import utility.*;

    public class TradingPostInsigniaBox extends Object
    {
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _bIsoState:Boolean;
        protected var _goldIcon:ItemDescriptionIcon;
        protected var _silverIcon:ItemDescriptionIcon;
        protected var _bMouseOverEnable:Boolean;

        public function TradingPostInsigniaBox(param1:DisplayObjectContainer)
        {
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.TRADINGPOST_PATH + "UI_Trade.swf", "insigniaMc");
            param1.addChild(this._mcBase);
            this._isoMain = new InStayOut(this._mcBase);
            this._bIsoState = false;
            this._goldIcon = new ItemDescriptionIcon(this._mcBase.insigniaBox.insigniaMc01, CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_GOLD_INSIGNIA, 0);
            this._goldIcon.setHitTestMc(this._mcBase.insigniaBox.insigniaMc01);
            this._silverIcon = new ItemDescriptionIcon(this._mcBase.insigniaBox.insigniaMc02, CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_SILVER_INSIGNIA, 0);
            this._silverIcon.setHitTestMc(this._mcBase.insigniaBox.insigniaMc02);
            TextControl.setText(this._mcBase.insigniaBox.textMc.textDt, MessageManager.getInstance().getMessage(MessageId.TRADINGPOST_INSIGNIA_NUM_TITLE));
            this._bMouseOverEnable = false;
            this.updateNum();
            return;
        }// end function

        public function get bClosed() : Boolean
        {
            return this._isoMain && this._isoMain.bClosed;
        }// end function

        public function get bAnimetion() : Boolean
        {
            return this._isoMain && this._isoMain.bAnimetion;
        }// end function

        public function release() : void
        {
            if (this._silverIcon)
            {
                this._silverIcon.release();
            }
            this._silverIcon = null;
            if (this._goldIcon)
            {
                this._goldIcon.release();
            }
            this._goldIcon = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        public function updateNum() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData.goldInsignia;
            var _loc_2:* = UserDataManager.getInstance().userData.silverInsignia;
            TextControl.setText(this._mcBase.insigniaBox.insigniaMc01.textMc.textDt, _loc_1.toString());
            TextControl.setText(this._mcBase.insigniaBox.insigniaMc02.textMc.textDt, _loc_2.toString());
            return;
        }// end function

        public function setMouseOverEnable(param1:Boolean) : void
        {
            this._bMouseOverEnable = param1;
            this.updateMouseOverEnable();
            return;
        }// end function

        private function updateMouseOverEnable() : void
        {
            var _loc_1:* = this._bMouseOverEnable && this._isoMain.bOpened && this._isoMain.bAnimetion == false;
            this._goldIcon.setMouseOverEnable(_loc_1);
            this._silverIcon.setMouseOverEnable(_loc_1);
            return;
        }// end function

        public function setIn() : void
        {
            this._bIsoState = true;
            if (this._isoMain && !this._isoMain.bOpened)
            {
                this._goldIcon.setMouseOverEnable(false);
                this._silverIcon.setMouseOverEnable(false);
                this._isoMain.setIn(this.cbIn);
            }
            return;
        }// end function

        public function setOut() : void
        {
            this._bIsoState = false;
            if (this._isoMain && this._isoMain.bOpened)
            {
                this._goldIcon.setMouseOverEnable(false);
                this._silverIcon.setMouseOverEnable(false);
                this._isoMain.setOut(this.cbOut);
            }
            return;
        }// end function

        private function cbIn() : void
        {
            if (this._bIsoState == false)
            {
                this._isoMain.setOut(this.cbOut);
            }
            else
            {
                this.updateMouseOverEnable();
            }
            return;
        }// end function

        private function cbOut() : void
        {
            if (this._bIsoState)
            {
                this._isoMain.setIn(this.cbIn);
            }
            else
            {
                this.updateMouseOverEnable();
            }
            return;
        }// end function

    }
}
