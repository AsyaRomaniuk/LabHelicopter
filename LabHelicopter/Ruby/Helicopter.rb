require "tk"
require "launchy"

$picture = nil

module Tk
  module RbWidget
    class BalloonHelp<TkLabel
    end
  end
end
class Tk::RbWidget::BalloonHelp<TkLabel
  DEFAULT_FOREGROUND = 'black'
  DEFAULT_BACKGROUND = 'white'
  DEFAULT_INTERVAL   = 750

  def _balloon_binding(interval)
    @timer = TkAfter.new(interval, 1, proc{show})
    def @timer.interval(val)
      @sleep_time = val
    end
    @bindtag = TkBindTag.new
    @bindtag.bind('Enter',  proc{@timer.start})
    @bindtag.bind('Motion', proc{@timer.restart; erase})
    @bindtag.bind('Any-ButtonPress', proc{@timer.restart; erase})
    @bindtag.bind('Leave',  proc{@timer.stop; erase})
    tags = @parent.bindtags
    idx = tags.index(@parent)
    unless idx
      ppath = TkComm.window(@parent.path)
      idx = tags.index(ppath) || 0
    end
    tags[idx,0] = @bindtag
    @parent.bindtags(tags)
  end
  private :_balloon_binding

  def initialize(parent=nil, keys={})
    @parent = parent || Tk.root

    @frame = TkToplevel.new(@parent)
    @frame.withdraw
    @frame.overrideredirect(true)
    @frame.transient(TkWinfo.toplevel(@parent))
    @epath = @frame.path

    if keys
      keys = _symbolkey2str(keys)
    else
      keys = {}
    end

    @command = keys.delete('command')

    @interval = keys.delete('interval'){DEFAULT_INTERVAL}
    _balloon_binding(@interval)

    # @label = TkLabel.new(@frame, 'background'=>'bisque').pack
    @label = TkLabel.new(@frame,
                         'foreground'=>DEFAULT_FOREGROUND,
                         'background'=>DEFAULT_BACKGROUND).pack
    @label.configure(_symbolkey2str(keys)) unless keys.empty?
    @path = @label
  end

  def epath
    @epath
  end

  def interval(val)
    if val
      @timer.interval(val)
    else
      @interval
    end
  end

  def command(cmd = nil, &block)
    @command = cmd || block
    self
  end

  def show
    x = TkWinfo.pointerx(@parent)
    y = TkWinfo.pointery(@parent)
    @frame.geometry("+#{x+1}+#{y+1}")

    if @command
      case @command.arity
      when 0
        @command.call
      when 2
        @command.call(x - TkWinfo.rootx(@parent), y - TkWinfo.rooty(@parent))
      when 3
        @command.call(x - TkWinfo.rootx(@parent), y - TkWinfo.rooty(@parent),
                      self)
      else
        @command.call(x - TkWinfo.rootx(@parent), y - TkWinfo.rooty(@parent),
                      self, @parent)
      end
    end

    @frame.deiconify
    @frame.raise

    begin
      @org_cursor = @parent.cget('cursor')
    rescue
      @org_cursor = @parent['cursor']
    end
    begin
      @parent.configure('cursor', 'arrow')
    rescue
      @parent.cursor('arrow')
    end
  end

  def erase
    begin
      @parent.configure('cursor', @org_cursor)
    rescue
      @parent.cursor(@org_cursor)
    end
    @frame.withdraw
  end

  def destroy
    @frame.destroy
  end
end

def CreatePicture(x1, y1, xb, yb, xe, ye, x2, y2, wd, ht, ya, lf, rg, un)
    
    def PrintCoords(xc, yc)
        $c.itemconfigure("text", :text=>"(#{xc};#{$h-yc})")
	end
    
    def create_tree(xc, yc, clr = "green", size = 1, h = 1000)
        TkcPolygon.new($c, xc-10*size, h-yc, xc+10*size, h-yc, xc+10*size, h-yc-10*size,
                        xc+40*size, h-yc, xc+20*size, h-yc-40*size, xc+30*size, h-yc-35*size,
                        xc+15*size, h-yc-65*size, xc+25*size, h-yc-60*size,
                        xc, h-yc-100*size, xc-25*size, h-yc-60*size,  xc-15*size, h-yc-65*size,
                        xc-30*size, h-yc-35*size, xc-20*size, h-yc-40*size, xc-40*size, h-yc,
                        xc-10*size, h-yc-10*size, "fill"=>clr)
	end
    $picture = TkToplevel.new()
    $picture.title("Малюнок")
    $picture.focus()
    $picture.attributes('fullscreen'=>1)
    
    rm = TkMenu.new($picture){tearoff 0}
    rm.add_command("label"=>"Закрити малюнок", "background"=>"#e8ffe8", 
	"command"=>proc{DestroyPicture(); Window.focus()})
    
    $c = TkCanvas.new($picture){
	bg "#e8ffe8"
	cursor "hand2"
	pack("fill"=>"both", "expand"=>1)}

    constant = x2 + x1
    bridgeconstant = (x2 - x1) * 0.08
    textinterval = 0
    $h = $c.winfo_screenheight()-1
    w = $c.winfo_screenwidth()
    rightside = TkcLine.new($c, constant, 0, constant, $h, "fill"=>"grey15", "width"=>2)
    polygon = TkcPolygon.new($c, 0, $h, 0, $h-y1, x1, $h-y1, xb, $h-ye, xe, $h-ye, x2, $h-y2, constant, $h-y2, constant, $h,
	"fill"=>"grey", "outline"=>"grey20", "width"=>2)
    water = TkcLine.new($c, xb, $h-ye, xe, $h-ye, "fill"=>"blue", "width"=>16) 
    column1 = TkcLine.new($c, xb, $h-yb, xb, $h-ye, "fill"=>"grey20", "width"=>10)
    column2 = TkcLine.new($c, xe, $h-ye, xe, $h-yb, "fill"=>"grey20", "width"=>10)
    bridge = TkcLine.new($c, x1, $h-y1, xb, $h-yb, xe, $h-yb, x2, $h-y2, "fill"=>"black", "width"=>4)
    topbridge = TkcLine.new($c, x1, $h - y1, xb, $h - yb - bridgeconstant, xe, $h - yb - bridgeconstant, x2, $h - y2, "width"=>2, "fill"=>"black")
    lineup = TkcLine.new($c, xb, $h - yb, xe, $h - yb - bridgeconstant, "width"=>2, "fill"=>"black")
    linedown = TkcLine.new($c, xb, $h - yb - bridgeconstant, xe, $h - yb, "width"=>2, "fill"=>"black")
    rect1 = TkcRectangle.new($c, x1/2+wd/2, $h-(y1+(ya-y1)/2)+ht/2, x1/2-wd/2, $h-(y1+(ya-y1)/2)-ht/2, "dash"=>[5, 1], "fill"=>lf, "outline"=>"blue", "width"=>3,
                                "activeoutline"=>"grey", "activefill"=>"#e8ffe8")
    rect2 = TkcRectangle.new($c, x2 + (constant-x2)/2+wd/2, $h-(y2+(ya-y2)/2+ht/2), x2 + (constant-x2)/2-wd/2, $h-(y2+(ya-y2)/2-ht/2), "dash"=>[5, 1], "fill"=>rg, "outline"=>"blue",
                                "width"=>3, "activeoutline"=>"grey", "activefill"=>"#e8ffe8")
    rect3 = TkcRectangle.new($c, xb + (xe - xb)/2 + wd/2, $h-(ye + (yb-ye)/2+ht/2), xb + (xe - xb)/2-wd/2, $h-(ye + (yb-ye)/2-ht/2), "dash"=>[5, 1], "fill"=>un, "outline"=>"blue",
                                "width"=>3, "activeoutline"=>"grey", "activefill"=>"#e8ffe8")
    dot1 = TkcOval.new($c, x1/2+5, $h-(y1+(ya-y1)/2)+5, x1/2-5, $h-(y1+(ya-y1)/2)-5, "fill"=>"cyan", "outline"=>"blue", "activefill"=>"#e8ffe8")
    dot2 = TkcOval.new($c, x2 + (constant-x2)/2+5, $h-(y2+(ya-y2)/2+5), x2 + (constant-x2)/2-5, $h-(y2+(ya-y2)/2-5), "fill"=>"cyan", "outline"=>"blue", "activefill"=>"#e8ffe8")
    dot3 = TkcOval.new($c, xb + (xe-xb)/2+5, $h-(ye + (yb-ye)/2+5), xb + (xe-xb)/2-5, $h-(ye + (yb-ye)/2-5), "fill"=>"cyan", "outline"=>"blue", "activefill"=>"#e8ffe8")
    txt1 = TkcText.new($c, x1/2, $h-(y1+(ya-y1)/2)-10, "text"=>"(#{x1/2};#{y1+(ya-y1)/2})")
    txt2 = TkcText.new($c, x2 + (constant-x2)/2, $h-(y2+(ya-y2)/2)-10, "text"=>"(#{x2 + (constant-x2)/2};#{y2+(ya-y2)/2})")
    txt3 = TkcText.new($c, xb + (xe-xb)/2, $h-(ye + (yb-ye)/2)-10, "text"=>"(#{xb + (xe-xb)/2};#{ye + (yb-ye)/2})")
	create_tree((xe+(x2-xe)*0.12), ye, "green", (yb-ye)*0.004, $h)
    create_tree(x1+(xb-x1)*0.88, ye, "green", (yb-ye)*0.004, $h)
    create_tree(x1+(xb-x1)*0.64, ye+(y1-ye)*0.24, "green", (yb-ye)*0.004, $h)
    limit = TkcLine.new($c, 0, $h-ya, constant, $h-ya, "dash"=>[5, 1], "fill"=>"red", "activefill"=>"black")
    c1 = TkcOval.new($c, x1+5, $h-(y1+5), x1-5, $h-(y1-5), "fill"=>"yellow", "outline"=>"white", "activeoutline"=>"black", "width"=>2)
    c2 = TkcOval.new($c, xb+5, $h-(yb+5), xb-5, $h-(yb-5), "fill"=>"yellow", "outline"=>"white", "activeoutline"=>"black", "width"=>2)
    c3 = TkcOval.new($c, xe+5, $h-(ye+5), xe-5, $h-(ye-5), "fill"=>"yellow", "outline"=>"white", "activeoutline"=>"black", "width"=>2)
    c4 = TkcOval.new($c, x2+5, $h-(y2+5), x2-5, $h-(y2-5), "fill"=>"yellow", "outline"=>"white", "activeoutline"=>"black", "width"=>2)
    TkcText.new($c, constant+(w-constant)/2, $h-$h/2, "text"=>"", "font"=>[".keyboard", 20], "tag"=>"text")
    TkcText.new($c, constant+(w-constant)/2, $h-$h/2-$h/4, "text"=>"", "font"=>[".keyboard", 20], "tag"=>"square")
    TkcText.new($c, constant+(w-constant)/2, $h-$h/2+$h/4, "text"=>"", "font"=>[".keyboard", 20], "tag"=>"coord")
    rect1.bind("Enter", proc{$c.itemconfigure("square", :text=>"#{wd}x#{ht}\nПлоща безпечної\nзони\n#{wd*ht} кв.од")})
    rect1.bind("Leave", proc{$c.itemconfigure("square", :text=>"")})
    rect2.bind("Enter", proc{$c.itemconfigure("square", :text=>"#{wd}x#{ht}\nПлоща безпечної\nзони\n#{wd*ht} кв.од")})
    rect2.bind("Leave", proc{$c.itemconfigure("square", :text=>"")})
    rect3.bind("Enter", proc{$c.itemconfigure("square", :text=>"#{wd}x#{ht}\nПлоща безпечної\nзони\n#{wd*ht} кв.од")})
    rect3.bind("Leave", proc{$c.itemconfigure("square", :text=>"")})
    limit.bind("Enter", proc{$c.itemconfigure("coord", :text=>"Максимальна безпечна\nвисота #{ya}")})
    limit.bind("Leave", proc{$c.itemconfigure("coord", :text=>"")})
    c1.bind("Enter", proc{$c.itemconfigure("coord", :text=>"(X1;Y1)\n#{x1};#{y1}")})
	c1.bind("Leave", proc{$c.itemconfigure("coord", :text=>"")})
    c2.bind("Enter", proc{$c.itemconfigure("coord", :text=>"(Xb;Yb)\n#{xb};#{yb}")})
    c2.bind("Leave", proc{$c.itemconfigure("coord", :text=>"")})
    c3.bind("Enter", proc{$c.itemconfigure("coord", :text=>"(Xe;Ye)\n#{xe};#{ye}")})
    c3.bind("Leave", proc{$c.itemconfigure("coord", :text=>"")})
    c4.bind("Enter", proc{$c.itemconfigure("coord", :text=>"(X2;Y2)\n#{x2};#{y2}")})
    c4.bind("Leave", proc{$c.itemconfigure("coord", :text=>"")})
    $c.bind("Button-1", proc{|x, y|PrintCoords(x, y)}, "%x %y")
    $c.bind("Button-3", proc{|x, y|rm.post(x, y)}, "%x %y")
end

def DestroyPicture()
    begin
        $picture.destroy()
    rescue
        nil
	end
end

def DATAEXAMPLE()
    ENTYa.delete(0, "end")
    ENTX1Y1.delete(0, "end")
    ENTXbYb.delete(0, "end")
    ENTXeYe.delete(0, "end")
    ENTX2Y2.delete(0, "end")
    ENTWH.delete(0, "end")
    ENTYa.insert(0, "360")
    ENTX1Y1.insert(0, "200 240")
    ENTXbYb.insert(0, "350 240")
    ENTXeYe.insert(0, "600 100")
    ENTX2Y2.insert(0, "750 240")
    ENTWH.insert(0, "150 60")
end

def EVAL()
    message = ""
    lf = "red"
    rg = "red"
    un = "red"
    begin
        ya = ENTYa.get().to_i
        x1, y1 = ENTX1Y1.get().split(" ").map{|n| n.to_i}
        xb, yb = ENTXbYb.get().split(" ").map{|n| n.to_i}
        xe, ye = ENTXeYe.get().split(" ").map{|n| n.to_i}
        x2, y2 = ENTX2Y2.get().split(" ").map{|n| n.to_i}
        wd, ht = ENTWH.get().split(" ").map{|n| n.to_i}
        constant = x2 + x1
		if (x1 - wd > 0) and (ya - y1 > ht)#над мостом зліва && and || or
            lf = "lightgreen"
            message += "Можна пролетіти над мостом зліва: (#{x1/2};#{y1 + (ya-y1)/2})\n"
		end
        if (ya - y2 > ht)#над мостом справа
            rg = "lightgreen"
            message += "Можна пролетіти над мостом справа: (#{x2 + (constant-x2)/2};#{y2+ (ya-y2)/2})\n"
		end
        if (ya > ye + (yb - ye)/2 + ht/2) and  (yb > ye + (yb - ye)/2 + ht/2) and (xb + wd < xe)#під мостом
            un = "lightgreen" 
            message += "Можна пролетіти під мостом:(#{xb + (xe - xb)/2};#{ye + (yb - ye)/2})"
		end
        if message == ""
            message = "На жаль, рекомендацій по шляху немає."
		end
        mb = Tk.messageBox("type"=>"ok", "icon"=>"info", "title"=>"Рекомендації", "message"=>message)
        constant = x2 + x1
	rescue
        mb = Tk.messageBox("type"=>"ok", "icon"=>"error", "title"=>"Сталася помилка!", "message"=>"Ви ввели недопустиме значення!")
	end
	DestroyPicture()
    CreatePicture(x1, y1, xb, yb, xe, ye, x2, y2, wd, ht, ya, lf, rg, un)
    '''rescue
        mb = Tk.messageBox("type"=>"ok", "icon"=>"error", "title"=>"Сталася помилка!", "message"=>"Ви ввели недопустиме значення!")
	end'''
end

def CLEARALL()
    ENTYa.delete(0, "end")
    ENTX1Y1.delete(0, "end")
    ENTXbYb.delete(0, "end")
    ENTXeYe.delete(0, "end")
    ENTX2Y2.delete(0, "end")
    ENTWH.delete(0, "end")
end


Window = TkRoot.new()
Window.focus()
Window.title("Вікно вхідних даних задачі")

LF = Tk::Labelframe.new(Window) {text 'ПРОЄКТ "БОЙОВИЙ ГВИНТОКРИЛ"'; font "times 14 bold"
pack(); labelanchor "n"}

LABTITLE = TkLabel.new(LF){text "Координати x, y вводяться через пробіл!"; font "Bold"
grid("row" => 0, "column" => 0, "columnspan" => 2)}

LABYa = TkLabel.new(LF){text "Координата макс. безпечної висоти Ya:"
grid("row" => 1, "column" => 0, "pady" => 10, "padx" => 10, "sticky" => "e")}
LABX1Y1 = TkLabel.new(LF){text "Координати лівого краю моста X1, Y1:"
grid("row" => 2, "column" => 0, "pady" => 10, "padx" => 10, "sticky" => "e")}
LABXbYb = TkLabel.new(LF){text "Координати моста Xb, Yb:"
grid("row" => 3, "column" => 0, "pady" => 10, "padx" => 10, "sticky" => "e")}
LABXeYe = TkLabel.new(LF){text "Координати землі Xe, Ye:"
grid("row" => 4, "column" => 0, "pady" => 10, "padx" => 10, "sticky" => "e")}
LABX2Y2 =TkLabel.new(LF){text "Координати правого краю моста X2, Y2:"
grid("row" => 5, "column" => 0, "pady" => 10, "padx" => 10, "sticky" => "e")}
LABWH = TkLabel.new(LF){text "Ширина і висота поля  W, H:"
grid("row" => 6, "column" => 0, "pady" => 10, "padx" => 10, "sticky" => "e")}

ENTYa = Tk::Tile::Entry.new(LF){width 22}
ENTYa.insert(0, "0")
ENTX1Y1 = Tk::Tile::Entry.new(LF){width 22}
ENTX1Y1.insert(0, "0 0")
ENTXbYb = Tk::Tile::Entry.new(LF){width 22}
ENTXbYb.insert(0, "0 0")
ENTXeYe = Tk::Tile::Entry.new(LF){width 22}
ENTXeYe.insert(0, "0 0")
ENTX2Y2 = Tk::Tile::Entry.new(LF){width 22}
ENTX2Y2.insert(0, "0 0")
ENTWH = Tk::Tile::Entry.new(LF){width 22}
ENTWH.insert(0, "0 0")

ENTYa.grid("row" => 1, "column" => 1, "pady" => 10, "padx" => 10)
ENTX1Y1.grid("row" => 2, "column" => 1, "pady" => 10, "padx" => 10)
ENTXbYb.grid("row" => 3, "column" => 1, "pady" => 10, "padx" => 10)
ENTXeYe.grid("row" => 4, "column" => 1, "pady" => 10, "padx" => 10)
ENTX2Y2.grid("row" => 5, "column" => 1, "pady" => 10, "padx" => 10)
ENTWH.grid("row" => 6, "column" => 1, "pady" => 10, "padx" => 10)

BUT1 = Tk::Tile::Button.new(LF){|b| text "Результат"; width 22; command "EVAL()"
grid("row" => 8, "sticky" => "sw")
Tk::RbWidget::BalloonHelp.new(b, :interval=>300, :text=>"Нажміть щоб отримати рекомендації")}
BUT2 = Tk::Tile::Button.new(LF){|b| text "Очистити поля"; width 22; command "CLEARALL()"
grid("row" => 7, "column" => 0, "sticky" => "sw")
Tk::RbWidget::BalloonHelp.new(b, :interval=>300, :text=>"Очищує координати полей Entry")}
BUT3 = Tk::Tile::Button.new(LF){|b| text "Детальніше про проєкт"; width 22
command 'Launchy.open("https://drive.google.com/file/d/1-MsFejNgq8smBRzNbeuYd4SR41UWCgvi/view?usp=sharing")'
Tk::RbWidget::BalloonHelp.new(b, :interval=>300, :text=>"Постановка задачі.pdf")
grid("row" => 8, "column" => 1, "sticky" => "se")}
BUT4 = Tk::Tile::Button.new(LF){|b| text "Контрольний приклад"; width 22; command "DATAEXAMPLE()"
Tk::RbWidget::BalloonHelp.new(b, :interval=>300, :text=>"Задає координати для наглядного прикладу")
grid("row" => 7, "column" => 1, "sticky" => "se")}

Window.mainloop()
