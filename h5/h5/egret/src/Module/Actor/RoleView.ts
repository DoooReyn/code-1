// TypeScript file

/**
 *
 * 方阵
 *
 */

class RoleView extends PlayerView {


   
    protected static instance:RoleView;
    public constructor(root?:any) {
        super(root);
        RoleView.instance = this;
        this.touchEnabled = false;
        this.width = this.info.w;
        this.height = this.info.h; 

        this.anchorOffsetX = this.width/2;
        this.anchorOffsetY = this.height/2;
    }

    public static getRoleView() {
        if (!RoleView.instance) {
            RoleView.instance = new RoleView();
        }
        return  RoleView.instance;
    }
}