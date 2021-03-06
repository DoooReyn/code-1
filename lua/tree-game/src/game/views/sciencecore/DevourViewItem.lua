--[[
	DevourViewItem
]]--

local DevourViewItem = class("DevourViewItem",function(  )
	-- body
	return ccui.Widget:create()
end)

function DevourViewItem:init(Parent)
	-- body
	self.Parent=Parent
	self.view=self.Parent:getClone()
	self:setContentSize(self.view:getContentSize())
	self.view:setPosition(0,0)
	self:addChild(self.view)

	self.btn = self.view:getChildByName("Button_choose_6")
	self.btn:addTouchEventListener(handler(self,self.TocallcomposeView))

	--品质
	self.Button_frame = self.view:getChildByName("Button_frame")
	--图像
	self.spr = self.Button_frame:getChildByName("Image_10")
	--lv 
	self.lv = self.Button_frame:getChildByName("Image_lv"):getChildByName("Text_lv_9")
	--名字
	self.name =self.view:getChildByName("Image_zb_bg"):getChildByName("Text_name") 
	--星星
	self.IconStar = self.view:getChildByName("Panel_star")
	--属性1 
	self.Pro1dec = self.view:getChildByName("Image_30_16")
	self.Pro1dec:ignoreContentAdaptWithSize(true)
	self.Pro1 = self.Pro1dec:getChildByName("Text_exp_13")
	--属性2
	self.Pro2dec = self.view:getChildByName("Image_30_16_0")
	self.Pro2dec:ignoreContentAdaptWithSize(true)
	self.Pro2 = self.Pro2dec:getChildByName("Text_exp_13_17")
	--属性3
	self.Pro3dec = self.view:getChildByName("Image_30_16_1")
	self.Pro3dec:ignoreContentAdaptWithSize(true)
	self.Pro3 = self.Pro3dec:getChildByName("Text_exp_13_15")

end
--设置物品的品质框 名字的颜色 
function  DevourViewItem:setFrameQuality( lv )
	-- body
	local framePath=res.btn.FRAME[lv]
	self.Button_frame:loadTextureNormal(framePath)
	self.name:setColor(COLOR[lv])
	self:addStar(lv)
end

--设置物品名字
function DevourViewItem:setLabName(name)
	self.name:setString(name)
end
--设置图像
function DevourViewItem:setBImage(imgpath)
	self.spr:loadTexture(imgpath)
end
--星星
function DevourViewItem:addStar( lv )
	-- body
	self.IconStar:removeAllChildren()
	for i = 1 , lv do 
		local sprite=display.newSprite(res.image.STAR)
		sprite:setPosition(sprite:getContentSize().width*(i-1),self.IconStar:getContentSize().height/2)
		self.IconStar:addChild(sprite)
	end
end

--设置属性
function DevourViewItem:setPro( Part,propertys )
	-- body
	local atk = 0
	local hp = 0
    --暴击
	local cri = 0
	--暴击伤害
	local crihurt = 0
	--抗暴
	local defcri = 0 
	--闪避
	local dodge = 0
	--命中
	local hit = 0
	if Part == 1 then 
		atk = mgr.ConfMgr.getItemAtK(propertys)
		hp = mgr.ConfMgr.getItemHp(propertys)
		crihurt = mgr.ConfMgr.getCritSh(propertys)
	elseif Part == 2 then 
		atk = mgr.ConfMgr.getItemAtK(propertys)
		hit = mgr.ConfMgr.getHit(propertys)
	elseif Part == 3  then 
		hp = mgr.ConfMgr.getItemHp(propertys)
		defcri = mgr.ConfMgr.getResistantCrit(propertys)
	elseif Part == 4 then
		atk = mgr.ConfMgr.getItemAtK(propertys)
		hp = mgr.ConfMgr.getItemHp(propertys)
		crihurt = mgr.ConfMgr.getCritSh(propertys)
	elseif  Part == 5 then 
		hp = mgr.ConfMgr.getItemHp(propertys)
		dodge = mgr.ConfMgr.getDodge(propertys)
	elseif  Part == 6 then 
		atk = mgr.ConfMgr.getItemAtK(propertys)
		cri = mgr.ConfMgr.getCrit(propertys)
	else
		atk = mgr.ConfMgr.getItemAtK(propertys)
		hp = mgr.ConfMgr.getItemHp(propertys)
	end	

	for i = 1 , 3 do 
		self["Pro"..i.."dec"]:setVisible(false)
	end 

	local bl=0
	local function _insetPro(png,v )
		-- body
		local k = pos 
		if v > 0 then 
			bl = bl +1 
			self["Pro"..bl.."dec"]:setVisible(true)
		  	self["Pro"..bl.."dec"]:loadTexture(png)
		  	self["Pro"..bl]:setString(v)

			local w =  self["Pro"..bl.."dec"]:getContentSize().width  
			self["Pro"..bl]:setPositionX(w+5)
			
		end
	end

	

	_insetPro(res.font.ATK,atk)
	_insetPro(res.font.HP,hp)
	_insetPro(res.font.CRIT,cri)
	_insetPro(res.font.CRIT_SH,crihurt)
	_insetPro(res.font.JR,defcri)
	_insetPro(res.font.MZ,hit)
	_insetPro(res.font.SB,dodge)
end

function DevourViewItem:setData( data )
	-- body
	self.btn:setEnabled(true)
	self.btn:setBright(true)

	self.data = data
	local type=conf.Item:getType(data.mId)
	local lv=conf.Item:getItemQuality(data.mId)
	self:setFrameQuality(lv)
	local name=conf.Item:getName(data.mId,data.propertys)
	local itemSrc=conf.Item:getSrc(data.mId)
	local part=conf.Item:getItemPart(data.mId)
	--local path=mgr.PathMgr.getItemImagePath(itemSrc)
	local currlv = data.propertys[303]  and data.propertys[303].value or 0

	local path = conf.Item:getItemSrcbymid(data.mId,data.propertys)
	if type == pack_type.SPRITE then 
		currlv =  data.propertys[304]  and data.propertys[304].value or 0
	end 	

	self.lv:setString(currlv)
	
	self:setLabName(name)
	
	self:setBImage(path)

	self:setPro(part,data.propertys)


end

function DevourViewItem:getPropByid(t,id)
	return t.propertys[id] and t.propertys[id].value or 0
end

function DevourViewItem:TocallcomposeView( send,eventtype  )
	-- body
	if eventtype == ccui.TouchEventType.ended then 
 		debugprint("选择了")
 		proxy.ScienceCore:send_127002({mid = self.data.mId,packIndex=self.data.index}) 
 		self.Parent:onCloseSelfView()
	end
end


return DevourViewItem