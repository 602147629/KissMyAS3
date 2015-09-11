package haxegame.scene
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import flash.*;
    import haxegame.save.*;
    import haxegame.se.*;

    public class Setting extends Object
    {
        public var view:SettingView;
        public var record:Record;
        public var onButton:MouseEventChecker;
        public var offButton:MouseEventChecker;
        public var layer:IDisplayObjectContainer;
        public var japaneseButton:MouseEventChecker;
        public var englishButton:MouseEventChecker;
        public var bgmPlayer:BgmPlayer;
        public var backButton:MouseEventChecker;

        public function Setting(param1:IDisplayObjectContainer = undefined) : void
        {
            var _loc_2:* = null as Record;
            var _loc_3:* = null as BgmPlayer;
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            if (Record.instance == null)
            {
                _loc_2 = new Record();
                Record.instance = _loc_2;
                record = _loc_2;
            }
            else
            {
                record = Record.instance;
            }
            if (BgmPlayer.instance == null)
            {
                _loc_3 = new BgmPlayer();
                BgmPlayer.instance = _loc_3;
                bgmPlayer = _loc_3;
            }
            else
            {
                bgmPlayer = BgmPlayer.instance;
            }
            view = new SettingView();
            var _loc_4:* = record.saveData.language;
            var _loc_5:* = _loc_4;
            if (_loc_5 == "eng")
            {
                view.japaneseActive.visible = false;
            }
            else if (_loc_5 == "ja")
            {
                view.englishActive.visible = false;
                ;
            }
            var _loc_6:* = record.saveData.bgm;
            switch(_loc_6.index) branch count is:<1>[15, 32] default offset is:<11>;
            ;
            view.offActive.visible = false;
            ;
            view.onActive.visible = false;
            englishButton = CommonClassSet.createMouseEventChecker(view.englishButton);
            japaneseButton = CommonClassSet.createMouseEventChecker(view.japaneseButton);
            onButton = CommonClassSet.createMouseEventChecker(view.onButton);
            offButton = CommonClassSet.createMouseEventChecker(view.offButton);
            backButton = CommonClassSet.createMouseEventChecker(view.backButton);
            return;
        }// end function

        public function show() : void
        {
            layer.addChild(view);
            return;
        }// end function

        public function run() : void
        {
            if (englishButton.isDowned())
            {
            }
            if (!view.englishActive.visible)
            {
                view.englishActive.visible = true;
                view.japaneseActive.visible = false;
                record.changeLanguage("eng");
            }
            else
            {
                if (japaneseButton.isDowned())
                {
                }
                if (!view.japaneseActive.visible)
                {
                    view.englishActive.visible = false;
                    view.japaneseActive.visible = true;
                    record.changeLanguage("ja");
                }
                else
                {
                    if (onButton.isDowned())
                    {
                    }
                    if (!view.onActive.visible)
                    {
                        view.onActive.visible = true;
                        view.offActive.visible = false;
                        record.changeBgm(BGM.ON);
                        bgmPlayer.playFromStop();
                    }
                    else
                    {
                        if (offButton.isDowned())
                        {
                        }
                        if (!view.offActive.visible)
                        {
                            view.onActive.visible = false;
                            view.offActive.visible = true;
                            record.changeBgm(BGM.OFF);
                            bgmPlayer.stop();
                        }
                    }
                }
            }
            englishButton.reset();
            japaneseButton.reset();
            onButton.reset();
            offButton.reset();
            backButton.reset();
            return;
        }// end function

        public function hide() : void
        {
            layer.removeChild(view);
            return;
        }// end function

    }
}
