pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;


contract copyright{

    enum Category {NIL, OTHER, LITERARY, SPEAK, ART, ARCHITECTURE, PHOTO, AUDIO, GRAPHICAL, SOFTWARE}
    enum CreateType {NIL, OTHER, ORIGINAL, ADAPT, TRANSLATE, COMPILE, NOTE, SORT}
    enum RightObtainType {NIL, OTHER, ORIGINAL, INHERIT, BEAR}
    enum RightOwnType {NIL, ALL, PUBLISH, SIGH, MODIFY, PROTECT, COPY, RELEASE, RENT, DISPLAY, SHOW, SCREEN, RADIO, SPREAD, PRODUCE, ADAPT, TRANSLATE, COMPILE, OTHER}
    enum Status {NIL, OTHER, UNCHECKED, UNDER_REVIEW, CHECKED, FALSE}
    enum AuthorType {NIL, OTHER, INTERNET, STAFF}
    enum IsStatus {NIL, TRUE, FALSE}

    struct Copyright  {
        /* 版权存证号。由SDK生成，规则为bsicop+当前时间戳+4位随机数 */
        string key;
        /* 作品名称 */
        string name;
        /* 作品数据指纹*/
        string dataFinger;
        /* 作品类别（详见作品类别枚举）*/
        Category category;
        /* 作品创作性质（详见作品创作性质枚举） */
        CreateType createType;
        /* 权利取得方式（详见权利取得方式枚举） */
        RightObtainType rightObtainType;
        /* 权利拥有方式（详见权利拥有方式枚举） */
        RightOwnType rightOwnType;
        /* 著作权人类型（详见著作权人类型枚举） */
        AuthorType authorType;
        /* 著作权人名称 */
        string authorName;
        /* 应用Id,用户地址 */
        address owner;
        /* 作品完成时间 */
        uint completionTime;
        /* 作品存储地址及提取码 */
        string workUrl;
        /* 版权局登记状态（详见版权局登记状态枚举） */
        Status status;
        /* 登记版权局 */
        string copyrightOffice;
        /* 链上存证有效状态（详见链上存证有效状态枚举） */
        IsStatus isStatus;
        /* 扩展信息、预留字段 */
        string extendField;
    }


    //    uint public copyrightIndex;
    mapping(string => Copyright) Copyrights;
    mapping(string => string) DataFingers;
    mapping(string => address) Uids;

    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        owner = msg.sender; // 在部署合约的时候，将owner设置为部署者的地址
    }


    // 版权登记
    function copyrightAdd(
        Copyright memory copyright,
        string memory Uid,
        bytes memory sign
    ) public returns (Copyright memory){

        //uid、sign判空
        require(keccak256(bytes(Uid)) != keccak256("") && sign.length != 0, "uid,sign is empty");

        //根据uid查询公钥，如果不存在，则存证失败。
         require(Uids[Uid] != address(0x0), "uid is not existed");

        //验签
        bytes32  signdata = getSigndata(copyright);
        require(ecrecovery(signdata,sign) == Uids[Uid], "verify failed");

        //key判重处理，如果key存在，则存证失败。
        //数据指纹判重处理，已存在，则存证失败。
        //key为主键版权信息上链。
        //数据指纹上链。
        require(addCopyrightToStore(copyright), "put failed");

        //返回上链结果信息

        return Copyrights[copyright.key];
    }

    function copyrightQuery(string memory key) public view returns (Copyright memory) {
        return Copyrights[key];
    }

    //版权更新
    function copyrightUpdate(
        Copyright memory copyright,
        string memory Uid,
        bytes memory sign
    ) public returns (Copyright memory){
        //uid、sign、key判空
        require(bytes(Uid).length != 0 && sign.length != 0 && bytes(copyright.key).length != 0, "uid,sign,key is empty");
        //根据uid查询公钥，如果不存在，则更新失败。
         require(Uids[Uid] != address(0x0), "uid is not existed");
        //文件指纹判重,若存在且不等于当前key则存证失败
        //即文件指纹不存在或和原来的相等
        string memory thekey = DataFingers[copyright.dataFinger];
        string memory newdataFinger = copyright.dataFinger;
        require(bytes(DataFingers[newdataFinger]).length == 0 || keccak256(abi.encodePacked(thekey)) == keccak256(abi.encodePacked(DataFingers[newdataFinger])), "dataFinger is empty or existed");
        //验签
        //获取链上的其他非空字段信息赋值给当前更新对象
        Copyright memory oldCopyright = Copyrights[copyright.key];
        if(bytes(copyright.name).length != 0) {
            oldCopyright.name = copyright.name;
        }
        if(bytes(copyright.dataFinger).length != 0) {
            oldCopyright.dataFinger = copyright.dataFinger;
        }
        if(copyright.category != Category.NIL) {
            oldCopyright.category = copyright.category;
        }
        if(copyright.createType != CreateType.NIL) {
            oldCopyright.createType = copyright.createType;
        }
        if(copyright.rightObtainType != RightObtainType.NIL) {
            oldCopyright.rightObtainType = copyright.rightObtainType;
        }
        if(copyright.rightOwnType != RightOwnType.NIL) {
            oldCopyright.rightOwnType = copyright.rightOwnType;
        }
        if(copyright.authorType != AuthorType.NIL) {
            oldCopyright.authorType = copyright.authorType;
        }
        if(bytes(copyright.authorName).length != 0) {
            oldCopyright.authorName = copyright.authorName;
        }
        if(copyright.owner != address(0x0)) {
            oldCopyright.owner = copyright.owner;
        }
        if(copyright.completionTime != 0) {
            oldCopyright.completionTime = copyright.completionTime;
        }
        if(bytes(copyright.workUrl).length != 0) {
            oldCopyright.workUrl = copyright.workUrl;
        }
        if(copyright.status != Status.NIL) {
            oldCopyright.status = copyright.status;
        }
        if(copyright.isStatus != IsStatus.NIL) {
            oldCopyright.isStatus = copyright.isStatus;
        }
        if(bytes(copyright.extendField).length != 0) {
            oldCopyright.extendField = copyright.extendField;
        }
        bytes32 signdata = getSigndata(oldCopyright);
        require(ecrecovery(signdata,sign) == Uids[Uid], "verify failed");
        // //文件指纹判重,若存在且不等于当前key则存证失败
        // string memory thedataFinger = DataFingers[copyright.dataFinger];
        // string memory newdataFinger = copyright.key;
        // require(bytes(thedataFinger).length != 0 && keccak256(abi.encodePacked(thedataFinger)) != keccak256(abi.encodePacked(newdataFinger)), "dataFinger is empty or existed");
        //链上更新版权信息
        Copyrights[copyright.key] = oldCopyright;
        DataFingers[copyright.dataFinger] = copyright.key;
        //返回上链结果信息
        return Copyrights[copyright.key];
    }

    function addCopyrightToStore(Copyright memory copyright) internal returns (bool) {

        // string memory key =  copyright.key;
        // Copyright memory thecopyright = Copyrights[copyright.key];


        //key判重处理，如果key存在，则存证失败。
        require(bytes(getKey(copyright.key)).length == 0, "key existed");

        require(bytes(DataFingers[copyright.dataFinger]).length == 0, "datafingers existed");
        Copyright memory copyright = Copyright(
            copyright.key,
            copyright.name,
            copyright.dataFinger,
            copyright.category,
            copyright.createType,
            copyright.rightObtainType,
            copyright.rightOwnType,
            copyright.authorType,
            copyright.authorName,
            copyright.owner,
            copyright.completionTime,
            copyright.workUrl,
            copyright.status,
            copyright.copyrightOffice,
            copyright.isStatus,
            copyright.extendField
        );
        Copyrights[copyright.key] = copyright;
        DataFingers[copyright.dataFinger] = copyright.key;

        return true;
    }

    function getSigndata(Copyright memory copyright) internal returns (bytes32){
        bytes memory data1=abi.encodePacked(
            copyright.key,
            copyright.name,
            copyright.dataFinger,
            copyright.category,
            copyright.createType,
            copyright.rightObtainType,
            copyright.rightOwnType);
        bytes memory data2=abi.encodePacked(
            copyright.authorType,
            copyright.authorName,
            copyright.owner,
            copyright.completionTime,
            copyright.workUrl,
            copyright.status,
            copyright.copyrightOffice,
            copyright.isStatus,
            copyright.extendField);
        return keccak256(abi.encodePacked(
                data1,data2
            ));

    }

    function getTheSigndata(Copyright memory copyright) public view returns (bytes32){
        bytes memory data1=abi.encodePacked(
            copyright.key,
            copyright.name,
            copyright.dataFinger,
            copyright.category,
            copyright.createType,
            copyright.rightObtainType,
            copyright.rightOwnType);
        bytes memory data2=abi.encodePacked(
            copyright.authorType,
            copyright.authorName,
            copyright.owner,
            copyright.completionTime,
            copyright.workUrl,
            copyright.status,
            copyright.copyrightOffice,
            copyright.isStatus,
            copyright.extendField);
        return keccak256(abi.encodePacked(
                data1,data2
            ));

    }

    function getKey(string memory key) internal returns (string memory) {
        return Copyrights[key].key;
    }

    function addUser(string memory uid, address add) public onlyOwner {
        Uids[uid] = add;
    }


    //验签
    function ecrecovery(bytes32 hash, bytes memory sig) internal returns (address) {
        bytes32 r;
        bytes32 s;
        uint8 v;

        if (sig.length != 65) {
            return address(0x0);
        }

        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := and(mload(add(sig, 65)), 255)
        }

        // https://github.com/ethereum/go-ethereum/issues/2053
        if (v < 27) {
            v += 27;
        }

        if (v != 27 && v != 28) {
            return address(0x0);
        }

        /* prefix might be needed for geth only
         * https://github.com/ethereum/go-ethereum/issues/3731
         */
        // bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        // hash = keccak256(abi.encodePacked(prefix, hash));

        return ecrecover(hash, v, r, s);
    }

}
