-- Modern GUI Library for Roblox
-- Inspired by Rayfield with modern dark theme

local Library = {}
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Lucide Icons mapping
local LucideIcons = {
    ["home"] = "rbxassetid://10734884548",
    ["settings"] = "rbxassetid://10734884919",
    ["user"] = "rbxassetid://10734885051",
    ["star"] = "rbxassetid://10734884982",
    ["search"] = "rbxassetid://10734884834",
    ["heart"] = "rbxassetid://10734884522",
    ["plus"] = "rbxassetid://10734884811",
    ["minus"] = "rbxassetid://10734884732",
    ["x"] = "rbxassetid://10734885018",
    ["check"] = "rbxassetid://10734884225",
    ["rewind"] = "rbxassetid://10734884852",
    ["play"] = "rbxassetid://10734884809",
    ["pause"] = "rbxassetid://10734884774",
    ["stop"] = "rbxassetid://10734884999",
    ["folder"] = "rbxassetid://10734884376",
    ["file"] = "rbxassetid://10734884351",
    ["download"] = "rbxassetid://10734884297",
    ["upload"] = "rbxassetid://10734885090",
    ["trash"] = "rbxassetid://10734885044",
    ["edit"] = "rbxassetid://10734884320",
    ["copy"] = "rbxassetid://10734884246",
    ["lock"] = "rbxassetid://10734884712",
    ["unlock"] = "rbxassetid://10734885072",
    ["eye"] = "rbxassetid://10734884342",
    ["eye-off"] = "rbxassetid://10734884354",
    ["info"] = "rbxassetid://10734884594",
    ["alert-triangle"] = "rbxassetid://10734884006",
    ["shield"] = "rbxassetid://10734884941",
    ["key"] = "rbxassetid://10734884639",
    ["mail"] = "rbxassetid://10734884718",
    ["phone"] = "rbxassetid://10734884796",
    ["camera"] = "rbxassetid://10734884142",
    ["image"] = "rbxassetid://10734884589",
    ["video"] = "rbxassetid://10734885096",
    ["music"] = "rbxassetid://10734884757",
    ["volume"] = "rbxassetid://10734885120",
    ["volume-off"] = "rbxassetid://10734885125",
    ["wifi"] = "rbxassetid://10734885149",
    ["bluetooth"] = "rbxassetid://10734884076",
    ["battery"] = "rbxassetid://10734884050",
    ["power"] = "rbxassetid://10734884825",
    ["refresh"] = "rbxassetid://10734884840",
    ["rotate"] = "rbxassetid://10734884862",
    ["maximize"] = "rbxassetid://10734884727",
    ["minimize"] = "rbxassetid://10734884739",
    ["move"] = "rbxassetid://10734884749",
    ["resize"] = "rbxassetid://10734884846",
    ["arrow-up"] = "rbxassetid://10734884030",
    ["arrow-down"] = "rbxassetid://10734884020",
    ["arrow-left"] = "rbxassetid://10734884025",
    ["arrow-right"] = "rbxassetid://10734884035",
    ["chevron-up"] = "rbxassetid://10734884204",
    ["chevron-down"] = "rbxassetid://10734884180",
    ["chevron-left"] = "rbxassetid://10734884186",
    ["chevron-right"] = "rbxassetid://10734884192",
    ["menu"] = "rbxassetid://10734884731",
    ["more-horizontal"] = "rbxassetid://10734884744",
    ["more-vertical"] = "rbxassetid://10734884751",
    ["grid"] = "rbxassetid://10734884486",
    ["list"] = "rbxassetid://10734884688",
    ["layout"] = "rbxassetid://10734884674",
    ["sidebar"] = "rbxassetid://10734884958",
    ["columns"] = "rbxassetid://10734884238",
    ["rows"] = "rbxassetid://10734884871",
    ["table"] = "rbxassetid://10734885020",
    ["bookmark"] = "rbxassetid://10734884086",
    ["tag"] = "rbxassetid://10734885026",
    ["flag"] = "rbxassetid://10734884369",
    ["pin"] = "rbxassetid://10734884805",
    ["paperclip"] = "rbxassetid://10734884786",
    ["link"] = "rbxassetid://10734884682",
    ["external-link"] = "rbxassetid://10734884339",
    ["globe"] = "rbxassetid://10734884483",
    ["compass"] = "rbxassetid://10734884242",
    ["map"] = "rbxassetid://10734884722",
    ["navigation"] = "rbxassetid://10734884759",
    ["target"] = "rbxassetid://10734885029",
    ["crosshair"] = "rbxassetid://10734884258",
    ["zap"] = "rbxassetid://10734885180",
    ["trending-up"] = "rbxassetid://10734885046",
    ["trending-down"] = "rbxassetid://10734885038",
    ["bar-chart"] = "rbxassetid://10734884048",
    ["pie-chart"] = "rbxassetid://10734884800",
    ["activity"] = "rbxassetid://10734883986",
    ["clock"] = "rbxassetid://10734884226",
    ["calendar"] = "rbxassetid://10734884135",
    ["sun"] = "rbxassetid://10734885014",
    ["moon"] = "rbxassetid://10734884742",
    ["cloud"] = "rbxassetid://10734884230",
    ["umbrella"] = "rbxassetid://10734885065",
    ["droplet"] = "rbxassetid://10734884302",
    ["thermometer"] = "rbxassetid://10734885031",
    ["wind"] = "rbxassetid://10734885155",
    ["snowflake"] = "rbxassetid://10734884975",
    ["flame"] = "rbxassetid://10734884364",
    ["lightning"] = "rbxassetid://10734884677",
    ["rainbow"] = "rbxassetid://10734884837",
    ["aperture"] = "rbxassetid://10734884016",
    ["focus"] = "rbxassetid://10734884374",
    ["zoom-in"] = "rbxassetid://10734885189",
    ["zoom-out"] = "rbxassetid://10734885194",
    ["scan"] = "rbxassetid://10734884878",
    ["qr-code"] = "rbxassetid://10734884832",
    ["barcode"] = "rbxassetid://10734884046",
    ["printer"] = "rbxassetid://10734884827",
    ["fax"] = "rbxassetid://10734884345",
    ["scanner"] = "rbxassetid://10734884876",
    ["monitor"] = "rbxassetid://10734884746",
    ["laptop"] = "rbxassetid://10734884665",
    ["tablet"] = "rbxassetid://10734885022",
    ["smartphone"] = "rbxassetid://10734884971",
    ["watch"] = "rbxassetid://10734885131",
    ["headphones"] = "rbxassetid://10734884520",
    ["speaker"] = "rbxassetid://10734884977",
    ["microphone"] = "rbxassetid://10734884735",
    ["radio"] = "rbxassetid://10734884835",
    ["tv"] = "rbxassetid://10734885060",
    ["gamepad"] = "rbxassetid://10734884448",
    ["joystick"] = "rbxassetid://10734884637",
    ["controller"] = "rbxassetid://10734884244",
    ["keyboard"] = "rbxassetid://10734884641",
    ["mouse"] = "rbxassetid://10734884755",
    ["usb"] = "rbxassetid://10734885088",
    ["hard-drive"] = "rbxassetid://10734884518",
    ["server"] = "rbxassetid://10734884926",
    ["database"] = "rbxassetid://10734884271",
    ["cloud-upload"] = "rbxassetid://10734884232",
    ["cloud-download"] = "rbxassetid://10734884228",
    ["inbox"] = "rbxassetid://10734884591",
    ["outbox"] = "rbxassetid://10734884784",
    ["send"] = "rbxassetid://10734884914",
    ["message-circle"] = "rbxassetid://10734884733",
    ["message-square"] = "rbxassetid://10734884737",
    ["chat"] = "rbxassetid://10734884174",
    ["comment"] = "rbxassetid://10734884240",
    ["quote"] = "rbxassetid://10734884830",
    ["help-circle"] = "rbxassetid://10734884524",
    ["question"] = "rbxassetid://10734884828",
    ["exclamation"] = "rbxassetid://10734884337",
    ["alert-circle"] = "rbxassetid://10734884004",
    ["warning"] = "rbxassetid://10734885129",
    ["error"] = "rbxassetid://10734884335",
    ["success"] = "rbxassetid://10734885012",
    ["info-circle"] = "rbxassetid://10734884596",
    ["bell"] = "rbxassetid://10734884054",
    ["bell-off"] = "rbxassetid://10734884052",
    ["notification"] = "rbxassetid://10734884763",
    ["alert"] = "rbxassetid://10734884002",
    ["badge"] = "rbxassetid://10734884041",
    ["award"] = "rbxassetid://10734884039",
    ["trophy"] = "rbxassetid://10734885048",
    ["medal"] = "rbxassetid://10734884729",
    ["gift"] = "rbxassetid://10734884477",
    ["package"] = "rbxassetid://10734884780",
    ["box"] = "rbxassetid://10734884088",
    ["archive"] = "rbxassetid://10734884018",
    ["briefcase"] = "rbxassetid://10734884104",
    ["shopping-bag"] = "rbxassetid://10734884943",
    ["shopping-cart"] = "rbxassetid://10734884945",
    ["credit-card"] = "rbxassetid://10734884256",
    ["wallet"] = "rbxassetid://10734885127",
    ["dollar-sign"] = "rbxassetid://10734884295",
    ["euro"] = "rbxassetid://10734884333",
    ["pound"] = "rbxassetid://10734884821",
    ["yen"] = "rbxassetid://10734885178",
    ["percent"] = "rbxassetid://10734884794",
    ["calculator"] = "rbxassetid://10734884133",
    ["ruler"] = "rbxassetid://10734884869",
    ["compass-tool"] = "rbxassetid://10734884242",
    ["wrench"] = "rbxassetid://10734885174",
    ["hammer"] = "rbxassetid://10734884514",
    ["screwdriver"] = "rbxassetid://10734884910",
    ["scissors"] = "rbxassetid://10734884906",
    ["knife"] = "rbxassetid://10734884643",
    ["pen"] = "rbxassetid://10734884790",
    ["pencil"] = "rbxassetid://10734884792",
    ["brush"] = "rbxassetid://10734884128",
    ["palette"] = "rbxassetid://10734884778",
    ["paint-bucket"] = "rbxassetid://10734884776",
    ["eyedropper"] = "rbxassetid://10734884347",
    ["ruler-triangle"] = "rbxassetid://10734884867",
    ["protractor"] = "rbxassetid://10734884829",
    ["square"] = "rbxassetid://10734884986",
    ["circle"] = "rbxassetid://10734884220",
    ["triangle"] = "rbxassetid://10734885042",
    ["hexagon"] = "rbxassetid://10734884532",
    ["pentagon"] = "rbxassetid://10734884788",
    ["octagon"] = "rbxassetid://10734884765",
    ["diamond"] = "rbxassetid://10734884289",
    ["rhombus"] = "rbxassetid://10734884850",
    ["parallelogram"] = "rbxassetid://10734884782",
    ["trapezoid"] = "rbxassetid://10734885036",
    ["cylinder"] = "rbxassetid://10734884269",
    ["cone"] = "rbxassetid://10734884243",
    ["sphere"] = "rbxassetid://10734884980",
    ["cube"] = "rbxassetid://10734884265",
    ["pyramid"] = "rbxassetid://10734884831",
    ["prism"] = "rbxassetid://10734884823",
    ["torus"] = "rbxassetid://10734885034",
    ["helix"] = "rbxassetid://10734884526",
    ["spiral"] = "rbxassetid://10734884984",
    ["wave"] = "rbxassetid://10734885133",
    ["sine"] = "rbxassetid://10734884961",
    ["cosine"] = "rbxassetid://10734884254",
    ["tangent"] = "rbxassetid://10734885027",
    ["graph"] = "rbxassetid://10734884484",
    ["chart"] = "rbxassetid://10734884176",
    ["histogram"] = "rbxassetid://10734884534",
    ["scatter"] = "rbxassetid://10734884880",
    ["line-chart"] = "rbxassetid://10734884680",
    ["area-chart"] = "rbxassetid://10734884022",
    ["donut"] = "rbxassetid://10734884293",
    ["gauge"] = "rbxassetid://10734884450",
    ["speedometer"] = "rbxassetid://10734884978",
    ["dashboard"] = "rbxassetid://10734884273",
    ["analytics"] = "rbxassetid://10734884014",
    ["trending"] = "rbxassetid://10734885040",
    ["growth"] = "rbxassetid://10734884494",
    ["decline"] = "rbxassetid://10734884281",
    ["profit"] = "rbxassetid://10734884825",
    ["loss"] = "rbxassetid://10734884714",
    ["balance"] = "rbxassetid://10734884043",
    ["scale"] = "rbxassetid://10734884874",
    ["weight"] = "rbxassetid://10734885141",
    ["measure"] = "rbxassetid://10734884725",
    ["length"] = "rbxassetid://10734884675",
    ["width"] = "rbxassetid://10734885151",
    ["height"] = "rbxassetid://10734884528",
    ["depth"] = "rbxassetid://10734884287",
    ["area"] = "rbxassetid://10734884024",
    ["volume"] = "rbxassetid://10734885122",
    ["density"] = "rbxassetid://10734884285",
    ["mass"] = "rbxassetid://10734884724",
    ["force"] = "rbxassetid://10734884378",
    ["energy"] = "rbxassetid://10734884329",
    ["power-icon"] = "rbxassetid://10734884825",
    ["voltage"] = "rbxassetid://10734885118",
    ["current"] = "rbxassetid://10734884267",
    ["resistance"] = "rbxassetid://10734884844",
    ["capacitor"] = "rbxassetid://10734884148",
    ["inductor"] = "rbxassetid://10734884593",
    ["transistor"] = "rbxassetid://10734885034",
    ["diode"] = "rbxassetid://10734884291",
    ["led"] = "rbxassetid://10734884673",
    ["bulb"] = "rbxassetid://10734884130",
    ["flashlight"] = "rbxassetid://10734884362",
    ["candle"] = "rbxassetid://10734884144",
    ["lamp"] = "rbxassetid://10734884663",
    ["lantern"] = "rbxassetid://10734884667",
    ["torch"] = "rbxassetid://10734885032",
    ["fire"] = "rbxassetid://10734884358",
    ["spark"] = "rbxassetid://10734884973",
    ["explosion"] = "rbxassetid://10734884341",
    ["bomb"] = "rbxassetid://10734884082",
    ["rocket"] = "rbxassetid://10734884863",
    ["plane"] = "rbxassetid://10734884807",
    ["helicopter"] = "rbxassetid://10734884530",
    ["car"] = "rbxassetid://10734884150",
    ["truck"] = "rbxassetid://10734885050",
    ["bus"] = "rbxassetid://10734884132",
    ["train"] = "rbxassetid://10734885035",
    ["subway"] = "rbxassetid://10734885010",
    ["taxi"] = "rbxassetid://10734885025",
    ["bike"] = "rbxassetid://10734884058",
    ["motorcycle"] = "rbxassetid://10734884753",
    ["scooter"] = "rbxassetid://10734884908",
    ["skateboard"] = "rbxassetid://10734884967",
    ["boat"] = "rbxassetid://10734884078",
    ["ship"] = "rbxassetid://10734884947",
    ["anchor"] = "rbxassetid://10734884012",
    ["sail"] = "rbxassetid://10734884873",
    ["wave-sea"] = "rbxassetid://10734885135",
    ["island"] = "rbxassetid://10734884635",
    ["mountain"] = "rbxassetid://10734884755",
    ["hill"] = "rbxassetid://10734884536",
    ["valley"] = "rbxassetid://10734885092",
    ["forest"] = "rbxassetid://10734884380",
    ["tree"] = "rbxassetid://10734885044",
    ["leaf"] = "rbxassetid://10734884671",
    ["branch"] = "rbxassetid://10734884100",
    ["flower"] = "rbxassetid://10734884372",
    ["rose"] = "rbxassetid://10734884865",
    ["tulip"] = "rbxassetid://10734885056",
    ["sunflower"] = "rbxassetid://10734885016",
    ["daisy"] = "rbxassetid://10734884275",
    ["grass"] = "rbxassetid://10734884488",
    ["seed"] = "rbxassetid://10734884912",
    ["sprout"] = "rbxassetid://10734884988",
    ["bloom"] = "rbxassetid://10734884074",
    ["petal"] = "rbxassetid://10734884798",
    ["stem"] = "rbxassetid://10734884994",
    ["root"] = "rbxassetid://10734884861",
    ["soil"] = "rbxassetid://10734884969",
    ["rock"] = "rbxassetid://10734884857",
    ["stone"] = "rbxassetid://10734885001",
    ["pebble"] = "rbxassetid://10734884786",
    ["crystal"] = "rbxassetid://10734884263",
    ["gem"] = "rbxassetid://10734884452",
    ["diamond-shape"] = "rbxassetid://10734884289",
    ["ruby"] = "rbxassetid://10734884867",
    ["emerald"] = "rbxassetid://10734884327",
    ["sapphire"] = "rbxassetid://10734884876",
    ["pearl"] = "rbxassetid://10734884786",
    ["gold"] = "rbxassetid://10734884481",
    ["silver"] = "rbxassetid://10734884959",
    ["bronze"] = "rbxassetid://10734884126",
    ["copper"] = "rbxassetid://10734884252",
    ["iron"] = "rbxassetid://10734884633",
    ["steel"] = "rbxassetid://10734884992",
    ["aluminum"] = "rbxassetid://10734884010",
    ["titanium"] = "rbxassetid://10734885030",
    ["platinum"] = "rbxassetid://10734884815",
    ["palladium"] = "rbxassetid://10734884774",
    ["rhodium"] = "rbxassetid://10734884848",
    ["iridium"] = "rbxassetid://10734884631",
    ["osmium"] = "rbxassetid://10734884782",
    ["rhenium"] = "rbxassetid://10734884846",
    ["tungsten"] = "rbxassetid://10734885058",
    ["molybdenum"] = "rbxassetid://10734884741",
    ["chromium"] = "rbxassetid://10734884218",
    ["nickel"] = "rbxassetid://10734884761",
    ["cobalt"] = "rbxassetid://10734884224",
    ["manganese"] = "rbxassetid://10734884720",
    ["zinc"] = "rbxassetid://10734885184",
    ["tin"] = "rbxassetid://10734885028",
    ["lead"] = "rbxassetid://10734884669",
    ["bismuth"] = "rbxassetid://10734884068",
    ["antimony"] = "rbxassetid://10734884016",
    ["arsenic"] = "rbxassetid://10734884028",
    ["selenium"] = "rbxassetid://10734884916",
    ["tellurium"] = "rbxassetid://10734885029",
    ["polonium"] = "rbxassetid://10734884817",
    ["astatine"] = "rbxassetid://10734884032",
    ["radon"] = "rbxassetid://10734884833",
    ["francium"] = "rbxassetid://10734884442",
    ["radium"] = "rbxassetid://10734884835",
    ["actinium"] = "rbxassetid://10734883988",
    ["thorium"] = "rbxassetid://10734885033",
    ["protactinium"] = "rbxassetid://10734884827",
    ["uranium"] = "rbxassetid://10734885086",
    ["neptunium"] = "rbxassetid://10734884759",
    ["plutonium"] = "rbxassetid://10734884813",
    ["americium"] = "rbxassetid://10734884008",
    ["curium"] = "rbxassetid://10734884265",
    ["berkelium"] = "rbxassetid://10734884056",
    ["californium"] = "rbxassetid://10734884137",
    ["einsteinium"] = "rbxassetid://10734884325",
    ["fermium"] = "rbxassetid://10734884349",
    ["mendelevium"] = "rbxassetid://10734884731",
    ["nobelium"] = "rbxassetid://10734884765",
    ["lawrencium"] = "rbxassetid://10734884667",
    ["rutherfordium"] = "rbxassetid://10734884871",
    ["dubnium"] = "rbxassetid://10734884304",
    ["seaborgium"] = "rbxassetid://10734884904",
    ["bohrium"] = "rbxassetid://10734884080",
    ["hassium"] = "rbxassetid://10734884516",
    ["meitnerium"] = "rbxassetid://10734884729",
    ["darmstadtium"] = "rbxassetid://10734884277",
    ["roentgenium"] = "rbxassetid://10734884859",
    ["copernicium"] = "rbxassetid://10734884250",
    ["nihonium"] = "rbxassetid://10734884763",
    ["flerovium"] = "rbxassetid://10734884366",
    ["moscovium"] = "rbxassetid://10734884751",
    ["livermorium"] = "rbxassetid://10734884708",
    ["tennessine"] = "rbxassetid://10734885031",
    ["oganesson"] = "rbxassetid://10734884767"
}

-- Helper functions
local function getIcon(iconName)
    if typeof(iconName) == "string" then
        return LucideIcons[iconName] or "rbxassetid://10734884548"
    elseif typeof(iconName) == "number" then
        return "rbxassetid://" .. tostring(iconName)
    end
    return "rbxassetid://10734884548"
end

local function createTween(object, info, properties)
    local tween = TweenService:Create(object, info, properties)
    tween:Play()
    return tween
end

local function createRippleEffect(button, clickPosition)
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.8
    ripple.BorderSizePixel = 0
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0, clickPosition.X, 0, clickPosition.Y)
    ripple.ZIndex = 100
    ripple.Parent = button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple
    
    local maxSize = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
    
    createTween(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, maxSize, 0, maxSize),
        Position = UDim2.new(0, clickPosition.X - maxSize/2, 0, clickPosition.Y - maxSize/2),
        BackgroundTransparency = 1
    })
    
    game:GetService("Debris"):AddItem(ripple, 0.5)
end

-- Main Library
function Library:CreateWindow(config)
    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernLibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = PlayerGui
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Size = UDim2.new(0, 650, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    -- Main Frame Corner
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame
    
    -- Shadow Effect
    local Shadow = Instance.new("Frame")
    Shadow.Name = "Shadow"
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 0.7
    Shadow.BorderSizePixel = 0
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.ZIndex = -1
    Shadow.Parent = MainFrame
    
    local ShadowCorner = Instance.new("UICorner")
    ShadowCorner.CornerRadius = UDim.new(0, 12)
    ShadowCorner.Parent = Shadow
    
    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    Sidebar.BorderSizePixel = 0
    Sidebar.Size = UDim2.new(0, 200, 1, 0)
    Sidebar.Position = UDim2.new(0, 0, 0, 0)
    Sidebar.Parent = MainFrame
    
    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 12)
    SidebarCorner.Parent = Sidebar
    
    -- Sidebar Content
    local SidebarContent = Instance.new("Frame")
    SidebarContent.Name = "Content"
    SidebarContent.BackgroundTransparency = 1
    SidebarContent.Size = UDim2.new(1, 0, 1, -60)
    SidebarContent.Position = UDim2.new(0, 0, 0, 60)
    SidebarContent.Parent = Sidebar
    
    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.Padding = UDim.new(0, 5)
    SidebarLayout.Parent = SidebarContent
    
    -- Library Title
    local TitleFrame = Instance.new("Frame")
    TitleFrame.Name = "TitleFrame"
    TitleFrame.BackgroundTransparency = 1
    TitleFrame.Size = UDim2.new(1, 0, 0, 50)
    TitleFrame.Position = UDim2.new(0, 0, 0, 0)
    TitleFrame.Parent = Sidebar
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.Text = config.Name or "Library"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.TextWrapped = true
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleFrame
    
    -- User Info
    local UserFrame = Instance.new("Frame")
    UserFrame.Name = "UserFrame"
    UserFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    UserFrame.BorderSizePixel = 0
    UserFrame.Size = UDim2.new(1, -20, 0, 40)
    UserFrame.Position = UDim2.new(0, 10, 1, -50)
    UserFrame.Parent = Sidebar
    
    local UserCorner = Instance.new("UICorner")
    UserCorner.CornerRadius = UDim.new(0, 8)
    UserCorner.Parent = UserFrame
    
    local UserIcon = Instance.new("ImageLabel")
    UserIcon.Name = "UserIcon"
    UserIcon.BackgroundTransparency = 1
    UserIcon.Size = UDim2.new(0, 24, 0, 24)
    UserIcon.Position = UDim2.new(0, 8, 0, 8)
    UserIcon.Image = getIcon("user")
    UserIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
    UserIcon.Parent = UserFrame
    
    local UserLabel = Instance.new("TextLabel")
    UserLabel.Name = "UserLabel"
    UserLabel.BackgroundTransparency = 1
    UserLabel.Size = UDim2.new(1, -40, 1, 0)
    UserLabel.Position = UDim2.new(0, 40, 0, 0)
    UserLabel.Text = Player.Name
    UserLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    UserLabel.TextScaled = true
    UserLabel.TextWrapped = true
    UserLabel.Font = Enum.Font.Gotham
    UserLabel.TextXAlignment = Enum.TextXAlignment.Left
    UserLabel.Parent = UserFrame
    
    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.BackgroundTransparency = 1
    ContentArea.Size = UDim2.new(1, -200, 1, 0)
    ContentArea.Position = UDim2.new(0, 200, 0, 0)
    ContentArea.Parent = MainFrame
    
    -- Tab Functions
    function Window:CreateTab(name, icon)
        local Tab = {}
        Tab.Elements = {}
        Tab.Name = name
        Tab.Icon = icon
        
        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton"
        TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, -20, 0, 40)
        TabButton.Position = UDim2.new(0, 10, 0, 0)
        TabButton.Text = ""
        TabButton.ClipsDescendants = true
        TabButton.Parent = SidebarContent
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabButton
        
        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Name = "TabIcon"
        TabIcon.BackgroundTransparency = 1
        TabIcon.Size = UDim2.new(0, 20, 0, 20)
        TabIcon.Position = UDim2.new(0, 10, 0, 10)
        TabIcon.Image = getIcon(icon)
        TabIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
        TabIcon.Parent = TabButton
        
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Name = "TabLabel"
        TabLabel.BackgroundTransparency = 1
        TabLabel.Size = UDim2.new(1, -40, 1, 0)
        TabLabel.Position = UDim2.new(0, 40, 0, 0)
        TabLabel.Text = name
        TabLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabLabel.TextScaled = true
        TabLabel.TextWrapped = true
        TabLabel.Font = Enum.Font.Gotham
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.Parent = TabButton
        
        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "TabContent"
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, -20, 1, -20)
        TabContent.Position = UDim2.new(0, 10, 0, 10)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 65)
        TabContent.BorderSizePixel = 0
        TabContent.Visible = false
        TabContent.Parent = ContentArea
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 10)
        ContentLayout.Parent = TabContent
        
        -- Auto-resize canvas
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
        end)
        
        -- Tab selection
        local function selectTab()
            -- Deselect all tabs
            for _, tab in pairs(Window.Tabs) do
                tab.Button.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
                tab.Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
                tab.Label.TextColor3 = Color3.fromRGB(150, 150, 150)
                tab.Content.Visible = false
            end
            
            -- Select current tab
            TabButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
            TabIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end
        
        TabButton.MouseButton1Click:Connect(function()
            selectTab()
        end)
        
        -- Hover effects
        TabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= Tab then
                createTween(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = Color3.fromRGB(35, 35, 40)
                })
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= Tab then
                createTween(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = Color3.fromRGB(25, 25, 30)
                })
            end
        end)
        
        -- Click effect
        TabButton.MouseButton1Down:Connect(function()
            local mouse = UserInputService:GetMouseLocation()
            local buttonPos = TabButton.AbsolutePosition
            local relativePos = Vector2.new(mouse.X - buttonPos.X, mouse.Y - buttonPos.Y)
            createRippleEffect(TabButton, relativePos)
        end)
        
        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.Icon = TabIcon
        Tab.Label = TabLabel
        
        -- Section Functions
        function Tab:CreateSection(name)
            local Section = {}
            
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = "Section"
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Size = UDim2.new(1, 0, 0, 30)
            SectionFrame.Parent = TabContent
            
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Name = "SectionLabel"
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Size = UDim2.new(1, 0, 1, 0)
            SectionLabel.Position = UDim2.new(0, 0, 0, 0)
            SectionLabel.Text = name
            SectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionLabel.TextScaled = true
            SectionLabel.TextWrapped = true
            SectionLabel.Font = Enum.Font.GothamBold
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            SectionLabel.Parent = SectionFrame
            
            function Section:Set(newName)
                SectionLabel.Text = newName
            end
            
            return Section
        end
        
        -- Divider Functions
        function Tab:CreateDivider()
            local Divider = {}
            
            local DividerFrame = Instance.new("Frame")
            DividerFrame.Name = "Divider"
            DividerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            DividerFrame.BorderSizePixel = 0
            DividerFrame.Size = UDim2.new(1, 0, 0, 2)
            DividerFrame.Parent = TabContent
            
            function Divider:Set(visible)
                DividerFrame.Visible = visible
            end
            
            return Divider
        end
        
        -- Button Functions
        function Tab:CreateButton(config)
            local Button = {}
            
            local ButtonFrame = Instance.new("TextButton")
            ButtonFrame.Name = "Button"
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Size = UDim2.new(1, 0, 0, 40)
            ButtonFrame.Text = ""
            ButtonFrame.ClipsDescendants = true
            ButtonFrame.Parent = TabContent
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Parent = ButtonFrame
            
            local ButtonLabel = Instance.new("TextLabel")
            ButtonLabel.Name = "ButtonLabel"
            ButtonLabel.BackgroundTransparency = 1
            ButtonLabel.Size = UDim2.new(1, -20, 1, 0)
            ButtonLabel.Position = UDim2.new(0, 20, 0, 0)
            ButtonLabel.Text = config.Name or "Button"
            ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonLabel.TextScaled = true
            ButtonLabel.TextWrapped = true
            ButtonLabel.Font = Enum.Font.Gotham
            ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
            ButtonLabel.Parent = ButtonFrame
            
            -- Button interactions
            ButtonFrame.MouseButton1Click:Connect(function()
                if config.Callback then
                    config.Callback()
                end
            end)
            
            ButtonFrame.MouseEnter:Connect(function()
                createTween(ButtonFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                })
            end)
            
            ButtonFrame.MouseLeave:Connect(function()
                createTween(ButtonFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                })
            end)
            
            ButtonFrame.MouseButton1Down:Connect(function()
                local mouse = UserInputService:GetMouseLocation()
                local buttonPos = ButtonFrame.AbsolutePosition
                local relativePos = Vector2.new(mouse.X - buttonPos.X, mouse.Y - buttonPos.Y)
                createRippleEffect(ButtonFrame, relativePos)
            end)
            
            return Button
        end
        
        -- Toggle Functions
        function Tab:CreateToggle(config)
            local Toggle = {}
            Toggle.Value = config.CurrentValue or false
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "Toggle"
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
            ToggleFrame.Parent = TabContent
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 8)
            ToggleCorner.Parent = ToggleFrame
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "ToggleLabel"
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Size = UDim2.new(1, -70, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 20, 0, 0)
            ToggleLabel.Text = config.Name or "Toggle"
            ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleLabel.TextScaled = true
            ToggleLabel.TextWrapped = true
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "ToggleButton"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            local ToggleButtonCorner = Instance.new("UICorner")
            ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
            ToggleButtonCorner.Parent = ToggleButton
            
            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Name = "ToggleIndicator"
            ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
            ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
            ToggleIndicator.Parent = ToggleButton
            
            local ToggleIndicatorCorner = Instance.new("UICorner")
            ToggleIndicatorCorner.CornerRadius = UDim.new(1, 0)
            ToggleIndicatorCorner.Parent = ToggleIndicator
            
            -- Set initial state
            local function updateToggle()
                if Toggle.Value then
                    createTween(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        BackgroundColor3 = Color3.fromRGB(0, 162, 255)
                    })
                    createTween(ToggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        Position = UDim2.new(1, -18, 0, 2)
                    })
                else
                    createTween(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        BackgroundColor3 = Color3.fromRGB(60, 60, 65)
                    })
                    createTween(ToggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        Position = UDim2.new(0, 2, 0, 2)
                    })
                end
            end
            
            updateToggle()
            
            ToggleButton.MouseButton1Click:Connect(function()
                Toggle.Value = not Toggle.Value
                updateToggle()
                if config.Callback then
                    config.Callback(Toggle.Value)
                end
            end)
            
            function Toggle:Set(value)
                Toggle.Value = value
                updateToggle()
            end
            
            return Toggle
        end
        
        -- Slider Functions
        function Tab:CreateSlider(config)
            local Slider = {}
            Slider.Value = config.CurrentValue or config.Range[1]
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = "Slider"
            SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Size = UDim2.new(1, 0, 0, 60)
            SliderFrame.Parent = TabContent
            
            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 8)
            SliderCorner.Parent = SliderFrame
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Name = "SliderLabel"
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Size = UDim2.new(1, -20, 0, 20)
            SliderLabel.Position = UDim2.new(0, 20, 0, 5)
            SliderLabel.Text = config.Name or "Slider"
            SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderLabel.TextScaled = true
            SliderLabel.TextWrapped = true
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = SliderFrame
            
            local SliderValue = Instance.new("TextLabel")
            SliderValue.Name = "SliderValue"
            SliderValue.BackgroundTransparency = 1
            SliderValue.Size = UDim2.new(0, 60, 0, 20)
            SliderValue.Position = UDim2.new(1, -80, 0, 5)
            SliderValue.Text = tostring(Slider.Value)
            SliderValue.TextColor3 = Color3.fromRGB(0, 162, 255)
            SliderValue.TextScaled = true
            SliderValue.TextWrapped = true
            SliderValue.Font = Enum.Font.GothamBold
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right
            SliderValue.Parent = SliderFrame
            
            local SliderTrack = Instance.new("Frame")
            SliderTrack.Name = "SliderTrack"
            SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Size = UDim2.new(1, -40, 0, 4)
            SliderTrack.Position = UDim2.new(0, 20, 0, 35)
            SliderTrack.Parent = SliderFrame
            
            local SliderTrackCorner = Instance.new("UICorner")
            SliderTrackCorner.CornerRadius = UDim.new(1, 0)
            SliderTrackCorner.Parent = SliderTrack
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Name = "SliderFill"
            SliderFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
            SliderFill.BorderSizePixel = 0
            SliderFill.Size = UDim2.new(0, 0, 1, 0)
            SliderFill.Position = UDim2.new(0, 0, 0, 0)
            SliderFill.Parent = SliderTrack
            
            local SliderFillCorner = Instance.new("UICorner")
            SliderFillCorner.CornerRadius = UDim.new(1, 0)
            SliderFillCorner.Parent = SliderFill
            
            local SliderHandle = Instance.new("Frame")
            SliderHandle.Name = "SliderHandle"
            SliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderHandle.BorderSizePixel = 0
            SliderHandle.Size = UDim2.new(0, 12, 0, 12)
            SliderHandle.Position = UDim2.new(0, -6, 0, -4)
            SliderHandle.Parent = SliderTrack
            
            local SliderHandleCorner = Instance.new("UICorner")
            SliderHandleCorner.CornerRadius = UDim.new(1, 0)
            SliderHandleCorner.Parent = SliderHandle
            
            -- Slider logic
            local function updateSlider()
                local percent = (Slider.Value - config.Range[1]) / (config.Range[2] - config.Range[1])
                SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                SliderHandle.Position = UDim2.new(percent, -6, 0, -4)
                SliderValue.Text = tostring(Slider.Value)
            end
            
            updateSlider()
            
            local dragging = false
            
            SliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local mouse = UserInputService:GetMouseLocation()
                    local trackPos = SliderTrack.AbsolutePosition
                    local trackSize = SliderTrack.AbsoluteSize
                    local relativeX = math.clamp((mouse.X - trackPos.X) / trackSize.X, 0, 1)
                    
                    Slider.Value = math.floor(config.Range[1] + (config.Range[2] - config.Range[1]) * relativeX)
                    updateSlider()
                    
                    if config.Callback then
                        config.Callback(Slider.Value)
                    end
                end
            end)
            
            function Slider:Set(value)
                Slider.Value = math.clamp(value, config.Range[1], config.Range[2])
                updateSlider()
            end
            
            return Slider
        end
        
 -- Dropdown Functions
function Tab:CreateDropdown(config)
    local Dropdown = {}
    Dropdown.Value = config.CurrentOption or config.Options[1]
    Dropdown.Open = false

    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = "Dropdown"
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
    DropdownFrame.ClipsDescendants = true
    DropdownFrame.Parent = TabContent

    local DropdownCorner = Instance.new("UICorner")
    DropdownCorner.CornerRadius = UDim.new(0, 8)
    DropdownCorner.Parent = DropdownFrame

    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Name = "DropdownButton"
    DropdownButton.BackgroundTransparency = 1
    DropdownButton.Size = UDim2.new(1, 0, 0, 40)
    DropdownButton.Text = config.Name or "Dropdown"
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.TextScaled = true
    DropdownButton.TextWrapped = true
    DropdownButton.Font = Enum.Font.Gotham
    DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    DropdownButton.Parent = DropdownFrame

    local Arrow = Instance.new("ImageLabel")
    Arrow.Name = "Arrow"
    Arrow.BackgroundTransparency = 1
    Arrow.Size = UDim2.new(0, 20, 0, 20)
    Arrow.Position = UDim2.new(1, -30, 0.5, -10)
    Arrow.Image = getIcon("chevron-down")
    Arrow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Arrow.Parent = DropdownFrame

    local OptionHolder = Instance.new("Frame")
    OptionHolder.Name = "OptionHolder"
    OptionHolder.BackgroundTransparency = 1
    OptionHolder.Position = UDim2.new(0, 0, 0, 40)
    OptionHolder.Size = UDim2.new(1, 0, 0, 0)
    OptionHolder.ClipsDescendants = true
    OptionHolder.Parent = DropdownFrame

    local OptionLayout = Instance.new("UIListLayout")
    OptionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    OptionLayout.Padding = UDim.new(0, 2)
    OptionLayout.Parent = OptionHolder

    local function toggleDropdown()
        Dropdown.Open = not Dropdown.Open
        local height = Dropdown.Open and (#config.Options * 30) or 0
        OptionHolder:TweenSize(UDim2.new(1, 0, 0, height), "Out", "Quad", 0.25, true)
        Arrow.Rotation = Dropdown.Open and 180 or 0
    end

    local function updateOptions()
        OptionHolder:ClearAllChildren()
        OptionLayout.Parent = OptionHolder
        for _, option in ipairs(config.Options) do
            local OptionBtn = Instance.new("TextButton")
            OptionBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            OptionBtn.Size = UDim2.new(1, -20, 0, 30)
            OptionBtn.Position = UDim2.new(0, 10, 0, 0)
            OptionBtn.Text = option
            OptionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            OptionBtn.Font = Enum.Font.Gotham
            OptionBtn.TextScaled = true
            OptionBtn.Parent = OptionHolder

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = OptionBtn

            OptionBtn.MouseButton1Click:Connect(function()
                Dropdown.Value = option
                DropdownButton.Text = option
                toggleDropdown()
                if config.Callback then
                    config.Callback(option)
                end
            end)
        end
    end

    DropdownButton.MouseButton1Click:Connect(function()
        toggleDropdown()
    end)

    updateOptions()
    DropdownButton.Text = Dropdown.Value

    function Dropdown:Set(value)
        Dropdown.Value = value
        DropdownButton.Text = value
        if config.Callback then
            config.Callback(value)
        end
    end

    return Dropdown
end
-- Input Field
function Tab:CreateInput(config)
    local Input = {}
    Input.Value = config.Default or ""

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Frame.BorderSizePixel = 0
    Frame.Parent = TabContent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Frame

    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(1, -20, 1, 0)
    Box.Position = UDim2.new(0, 10, 0, 0)
    Box.Text = Input.Value
    Box.ClearTextOnFocus = false
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.BackgroundTransparency = 1
    Box.Font = Enum.Font.Gotham
    Box.TextScaled = true
    Box.TextWrapped = true
    Box.TextXAlignment = Enum.TextXAlignment.Left
    Box.Parent = Frame

    Box.FocusLost:Connect(function()
        Input.Value = Box.Text
        if config.Callback then
            config.Callback(Box.Text)
        end
    end)

    function Input:Set(text)
        Input.Value = text
        Box.Text = text
    end

    return Input
end

-- Notifications
function Library:Notify(text, duration)
    duration = duration or 3
    local Notification = Instance.new("TextLabel")
    Notification.Size = UDim2.new(0, 300, 0, 40)
    Notification.Position = UDim2.new(1, -320, 1, -100)
    Notification.AnchorPoint = Vector2.new(1, 1)
    Notification.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    Notification.Text = text
    Notification.TextScaled = true
    Notification.Font = Enum.Font.Gotham
    Notification.BorderSizePixel = 0
    Notification.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Notification

    createTween(Notification, TweenInfo.new(0.25), {Position = UDim2.new(1, -320, 1, -120)})
    task.delay(duration, function()
        createTween(Notification, TweenInfo.new(0.25), {Position = UDim2.new(1, -320, 1, 0)})
        game:GetService("Debris"):AddItem(Notification, 0.5)
    end)
end

-- Theme Support
Library.Theme = "Dark"
function Library:SetTheme(theme)
    self.Theme = theme
    -- implement theme color changes later
end

-- Save/Load Settings
Library.Settings = {}
function Library:SaveSettings()
    local encoded = HttpService:JSONEncode(self.Settings)
    if writefile then
        writefile("aurora_settings.json", encoded)
    end
end

function Library:LoadSettings()
    if isfile and isfile("aurora_settings.json") then
        local data = readfile("aurora_settings.json")
        self.Settings = HttpService:JSONDecode(data)
    end
end

-- Key System
function Library:KeySystem(correctKey, callback)
    local KeyGui = Instance.new("ScreenGui", PlayerGui)
    KeyGui.Name = "AuroraKeyUI"

    local Frame = Instance.new("Frame", KeyGui)
    Frame.Size = UDim2.new(0, 300, 0, 150)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Frame.BorderSizePixel = 0

    local Corner = Instance.new("UICorner", Frame)
    Corner.CornerRadius = UDim.new(0, 10)

    local Input = Instance.new("TextBox", Frame)
    Input.PlaceholderText = "Enter key..."
    Input.Size = UDim2.new(1, -20, 0, 40)
    Input.Position = UDim2.new(0, 10, 0, 30)
    Input.Text = ""
    Input.TextColor3 = Color3.fromRGB(255, 255, 255)
    Input.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Input.Font = Enum.Font.Gotham
    Input.TextScaled = true
    Input.ClearTextOnFocus = true

    local Submit = Instance.new("TextButton", Frame)
    Submit.Text = "Submit"
    Submit.Size = UDim2.new(1, -20, 0, 40)
    Submit.Position = UDim2.new(0, 10, 0, 80)
    Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
    Submit.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    Submit.Font = Enum.Font.Gotham
    Submit.TextScaled = true

    Submit.MouseButton1Click:Connect(function()
        if Input.Text == correctKey then
            KeyGui:Destroy()
            if callback then callback() end
        else
            Input.Text = "Wrong key!"
        end
    end)
end
function Tab:CreateColorPicker(config)
    local Picker = {}
    Picker.Value = config.CurrentColor or Color3.fromRGB(255, 255, 255)

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Frame.BorderSizePixel = 0
    Frame.Parent = TabContent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Text = config.Name or "Color Picker"
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local ColorBtn = Instance.new("TextButton")
    ColorBtn.Size = UDim2.new(0, 30, 0, 30)
    ColorBtn.Position = UDim2.new(1, -40, 0.5, -15)
    ColorBtn.BackgroundColor3 = Picker.Value
    ColorBtn.BorderSizePixel = 0
    ColorBtn.Text = ""
    ColorBtn.Parent = Frame

    local ColorCorner = Instance.new("UICorner")
    ColorCorner.CornerRadius = UDim.new(1, 0)
    ColorCorner.Parent = ColorBtn

    ColorBtn.MouseButton1Click:Connect(function()
        local color = Picker.Value
        local picked = game:GetService("StarterGui"):PromptColorPicker(color)
        if picked then
            Picker.Value = picked
            ColorBtn.BackgroundColor3 = picked
            if config.Callback then
                config.Callback(picked)
            end
        end
    end)

    function Picker:Set(value)
        Picker.Value = value
        ColorBtn.BackgroundColor3 = value
        if config.Callback then
            config.Callback(value)
        end
    end

    return Picker
end
do
    local UIS = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local dragging, dragInput, dragStart, startPos

    local gui = PlayerGui:WaitForChild("ModernLibrary"):WaitForChild("MainFrame")

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- K to toggle visibility
    UIS.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.K then
            gui.Visible = not gui.Visible
        end
    end)
end
return Library
