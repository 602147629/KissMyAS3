package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class GameSystem extends Window
    {
        private var mainpanel:Sprite;
        private var menubar:ButtonBar;
        private var reloginbtn:PushButton;
        private var backbtn:PushButton;
        private var fullstage:CheckBox;
        private var shadowcheck:CheckBox;
        private var soundbtn:CheckBox;
        private var musicbtn:CheckBox;
        private var temparr:Array;
        public var _disturbCB:CheckBox;
        public var _chatCB:CheckBox;
        public var _otherVisibleCB:CheckBox;
        private var _unitShadowCB:CheckBox;
        private var _mapShadowCB:CheckBox;
        private var _soundCB:CheckBox;
        private var _musicCB:CheckBox;
        private var _musicBackCB:CheckBox;
        private var _quickView:ClickLabel;
        private var _quickViewID:Number = -1;
        public static var _preMusicOn:Boolean = false;

        public function GameSystem(param1:DisplayObjectContainer)
        {
            super(param1);
            this.initpanel();
            this.setMusic(_preMusicOn);
            return;
        }// end function

        private function quitGame(param1)
        {
            AlertUI.alert(Config.language("GameSystem", 1), Config.language("GameSystem", 2), [Config.language("GameSystem", 3), Config.language("GameSystem", 4)], [this.doQuitGame, null]);
            return;
        }// end function

        private function doQuitGame(param1)
        {
            Config.normalQuit = true;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LOGOUT);
            ClientSocket.send(_loc_2);
            setTimeout(this.subQuitGame, 1000);
            return;
        }// end function

        private function subQuitGame()
        {
            try
            {
                ExternalInterface.call("eval", "location.reload();");
            }
            catch (e)
            {
            }
            return;
        }// end function

        public function setCookie()
        {
            Config.startLoop(this.subSetCookie);
            return;
        }// end function

        public function subSetCookie(param1 = null)
        {
            Config.stopLoop(this.subSetCookie);
            var _loc_2:* = {};
            _loc_2[0] = this._unitShadowCB.selected;
            _loc_2[1] = this._mapShadowCB.selected;
            _loc_2[2] = this._soundCB.selected;
            _loc_2[3] = this._musicCB.selected;
            _loc_2[4] = Config.disturbMode;
            _loc_2[5] = Config.chatMode;
            _loc_2[6] = this._musicBackCB.selected;
            Config.cookie.put("systemSet", _loc_2);
            return;
        }// end function

        public function getCookie()
        {
            Config.startLoop(this.subGetCookie);
            return;
        }// end function

        private function subGetCookie(param1 = null)
        {
            Config.stopLoop(this.subGetCookie);
            var _loc_2:* = Config.cookie.get("systemSet");
            this._unitShadowCB.selected = _loc_2[0];
            this._mapShadowCB.selected = _loc_2[1];
            this._soundCB.selected = _loc_2[2];
            this._musicCB.selected = _loc_2[3];
            Config.disturbMode = _loc_2[4];
            Config.chatMode = _loc_2[5];
            this._musicBackCB.selected = _loc_2[6];
            var _loc_3:* = this._unitShadowCB.selected;
            DropClip.shadow = this._unitShadowCB.selected;
            UnitClip.shadow = _loc_3;
            Config.map.halo = this._mapShadowCB.selected;
            SoundManager.soundOn = this._soundCB.selected;
            SoundManager.musicOn = this._musicCB.selected;
            SoundManager.musicBack = this._musicBackCB.selected;
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            resize(200, 310);
            this.title = Config.language("GameSystem", 5);
            _loc_1 = new Label(this, 10, 30, Config.language("GameSystem", 6));
            _loc_1 = new Label(this, 10, 90, Config.language("GameSystem", 7));
            _loc_1 = new Label(this, 10, 170, Config.language("GameSystem", 8));
            if (!Config._switchMobage)
            {
                _loc_2 = new PushButton(this, 110, 275, Config.language("GameSystem", 9), this.quitGame);
                _loc_2.width = 80;
            }
            _loc_2 = new PushButton(this, 10, 275, Config.language("GameSystem", 10), this.returnGame);
            _loc_2.width = 80;
            if (Config._switchMobage)
            {
                _loc_2.x = 60;
            }
            this._unitShadowCB = new CheckBox(this, 20, 60, Config.language("GameSystem", 11), this.unitShadow);
            this._mapShadowCB = new CheckBox(this, 110, 60, Config.language("GameSystem", 12), this.mapShadow);
            this._soundCB = new CheckBox(this, 20, 120, Config.language("GameSystem", 13), this.soundSwitch);
            this._soundCB.selected = true;
            this._musicCB = new CheckBox(this, 110, 120, Config.language("GameSystem", 14), this.musicSwitch);
            this._musicCB.selected = true;
            this._musicBackCB = new CheckBox(this, 20, 140, Config.language("GameSystem", 21), this.handleBackMusic);
            this._disturbCB = new CheckBox(this, 20, 200, Config.language("GameSystem", 15), this.handleDisturb);
            this._disturbCB.selected = false;
            this._chatCB = new CheckBox(this, 110, 200, Config.language("GameSystem", 16), this.handleChat);
            this._chatCB.selected = false;
            this._otherVisibleCB = new CheckBox(this, 20, 220, Config.language("GameSystem", 17), this.handleOtherVisible);
            this._otherVisibleCB.selected = false;
            _loc_2 = new PushButton(this, 10, 245, Config.language("Radar", 54), this.handleEscape, null, "table18", "table31");
            _loc_2.textColor = Style.GOLD_FONT;
            _loc_2.width = 80;
            _loc_2.overshow = true;
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.handleEscapeOver);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleEscapeOut);
            if (Config.cookie.contains("systemSet"))
            {
                this.getCookie();
            }
            else
            {
                this.setCookie();
            }
            return;
        }// end function

        public function handleEscape(param1 = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ESCAPE_BLOCK);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleEscapeOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            Holder.showInfo(Config.language("Radar", 12), new Rectangle(_loc_2.x + _loc_2.parent.x, _loc_2.y + _loc_2.parent.y, _loc_2.width, _loc_2.height), true);
            return;
        }// end function

        private function handleEscapeOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleBackMusic(param1)
        {
            SoundManager.musicBack = param1.currentTarget.selected;
            this.setCookie();
            return;
        }// end function

        private function handleQuickView(param1)
        {
            if (this._quickViewID != -1)
            {
                AlertUI.remove(this._quickViewID);
            }
            var _loc_2:* = Config.language("GameSystem", 18);
            this._quickViewID = AlertUI.alert(Config.language("GameSystem", 19), _loc_2, [Config.language("GameSystem", 20)]);
            return;
        }// end function

        private function handleOtherVisible(param1 = null)
        {
            Unit.otherVisible = !this._otherVisibleCB.selected;
            return;
        }// end function

        private function handleChat(param1)
        {
            Config.chatMode = this._chatCB.selected;
            return;
        }// end function

        private function handleDisturb(param1)
        {
            Config.disturbMode = this._disturbCB.selected;
            return;
        }// end function

        private function returnGame(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

        private function unitShadow(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget.selected;
            DropClip.shadow = event.currentTarget.selected;
            UnitClip.shadow = _loc_2;
            this.setCookie();
            return;
        }// end function

        private function mapShadow(event:MouseEvent) : void
        {
            Config.map.halo = event.currentTarget.selected;
            this.setCookie();
            return;
        }// end function

        private function soundSwitch(event:MouseEvent) : void
        {
            SoundManager.soundOn = event.currentTarget.selected;
            this.setCookie();
            return;
        }// end function

        private function musicSwitch(event:MouseEvent) : void
        {
            SoundManager.musicOn = event.currentTarget.selected;
            this.setCookie();
            return;
        }// end function

        public function gameSoundSwitch(param1:Boolean) : void
        {
            SoundManager.soundOn = param1;
            SoundManager.musicOn = param1;
            this._soundCB.selected = param1;
            this._musicCB.selected = param1;
            this.setCookie();
            return;
        }// end function

        public function setMusic(param1)
        {
            this._musicCB.selected = param1;
            this.setCookie();
            return;
        }// end function

    }
}
