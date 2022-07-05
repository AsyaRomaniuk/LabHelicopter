from tkinter import *
from tkinter.messagebox import showerror, showinfo
from tkinter.tix import Balloon, Tk
from tkinter.ttk import Button, Entry
from webbrowser import open_new

picture = None

def CreatePicture(X1, Y1, Xb, Yb, Xe, Ye, X2, Y2, W, H, Ya, left, right, under):
    global picture
    
    def PrintCoords(event):
        c.itemconfig("text", text=f"({event.x};{h-event.y})")
    
    def create_tree(x, y, clr = "green", size = 1, h = 1000):
        c.create_polygon((x-10*size, h-y), (x+10*size, h-y), (x+10*size, h-y-10*size),
                        (x+40*size, h-y), (x+20*size, h-y-40*size), (x+30*size, h-y-35*size),
                        (x+15*size, h-y-65*size), (x+25*size, h-y-60*size),
                         (x, h-y-100*size), (x-25*size, h-y-60*size),  (x-15*size, h-y-65*size),
                         (x-30*size, h-y-35*size), (x-20*size, h-y-40*size), (x-40*size, h-y),
                            (x-10*size, h-y-10*size), fill=clr)
    picture = Tk()
    picture.title("Малюнок")
    picture.focus()
    picture.attributes('-fullscreen', True)
    
    RM = Menu(picture, tearoff=0)
    RM.add_command(label="Закрити малюнок", background="#e8ffe8", command=lambda: (picture.destroy(), Window.focus()))
    
    c = Canvas(picture, bg="#e8ffe8", cursor="hand2")

    constant = X2 + X1 
    bridgeconstant = (X2 - X1) * 0.08
    textinterval = 0
    h = c.winfo_screenheight()-1
    w = c.winfo_screenwidth()
    
    rightside = c.create_line((constant, 0), (constant, h), fill = 'grey15', width = 2)
    polygon = c.create_polygon((0, h), (0, h-Y1), (X1, h-Y1), (Xb, h-Ye), (Xe, h-Ye), (X2, h-Y2), (constant, h-Y2), (constant, h), fill="grey", outline="grey20", width=2)
    water = c.create_line((Xb, h-Ye), (Xe, h-Ye), fill="blue", width=16) 
    column1 = c.create_line((Xb,h-Yb), (Xb, h-Ye), fill="grey20", width=10)
    column2 = c.create_line((Xe, h-Ye), (Xe, h-Yb), fill="grey20", width=10)
    bridge = c.create_line((X1, h-Y1), (Xb,h-Yb), (Xe, h-Yb), (X2, h-Y2), fill="black", width=4)
    topbridge = c.create_line((X1, h - Y1), (Xb, h - Yb - bridgeconstant), (Xe, h - Yb - bridgeconstant), (X2, h - Y2), width = 2, fill = "black")
    lineup = c.create_line((Xb, h - Yb), (Xe, h - Yb - bridgeconstant), width = 2, fill = "black")
    linedown = c.create_line((Xb, h - Yb - bridgeconstant), (Xe, h - Yb), width = 2, fill = "black")
    rect1 = c.create_rectangle(X1/2+W/2, h-(Y1+(Ya-Y1)/2)+H/2, X1/2-W/2, h-(Y1+(Ya-Y1)/2)-H/2, dash=(5, 1), fill=left, outline="blue", width=3,
                               activeoutline="grey", activefill="#e8ffe8")
    rect2 = c.create_rectangle(X2 + (constant-X2)/2+W/2, h-(Y2+(Ya-Y2)/2+H/2), X2 + (constant-X2)/2-W/2,h-(Y2+(Ya-Y2)/2-H/2), dash=(5, 1), fill=right, outline="blue",
                               width=3, activeoutline="grey", activefill="#e8ffe8")
    rect3 = c.create_rectangle(Xb + (Xe - Xb)/2 + W/2, h-(Ye + (Yb-Ye)/2+H/2), Xb + (Xe - Xb)/2-W/2, h-(Ye + (Yb-Ye)/2-H/2), dash=(5, 1), fill=under, outline="blue",
                               width=3, activeoutline="grey", activefill="#e8ffe8")
    dot1 = c.create_oval(X1/2+5, h-(Y1+(Ya-Y1)/2)+5, X1/2-5, h-(Y1+(Ya-Y1)/2)-5, fill="cyan", outline="blue", activefill="#e8ffe8")
    dot2 = c.create_oval(X2 + (constant-X2)/2+5, h-(Y2+(Ya-Y2)/2+5), X2 + (constant-X2)/2-5,h-(Y2+(Ya-Y2)/2-5), fill="cyan", outline="blue", activefill="#e8ffe8")
    dot3 = c.create_oval(Xb + (Xe-Xb)/2+5, h-(Ye + (Yb-Ye)/2+5), Xb + (Xe-Xb)/2-5, h-(Ye + (Yb-Ye)/2-5), fill="cyan", outline="blue", activefill="#e8ffe8")
    txt1 = c.create_text(X1/2, h-(Y1+(Ya-Y1)/2)-10, text="("+str(X1/2)+";"+str((Y1+(Ya-Y1)/2))+")")
    txt2 = c.create_text(X2 + (constant-X2)/2, h-(Y2+(Ya-Y2)/2)-10, text="("+str(X2 + (constant-X2)/2)+";"+str((Y2+(Ya-Y2)/2))+")")
    txt3 = c.create_text(Xb + (Xe-Xb)/2, h-(Ye + (Yb-Ye)/2)-10, text="("+str(Xb + (Xe-Xb)/2)+";"+str((Ye + (Yb-Ye)/2))+")")
    create_tree((Xe+(X2-Xe)*0.12), Ye, h=h, size = (Yb-Ye)*4*10**-3)
    create_tree(X1+(Xb-X1)*0.88, Ye, h=h, size = (Yb-Ye)*4*10**-3)
    create_tree(X1+(Xb-X1)*0.64, Ye+(Y1-Ye)*0.24, h=h, size = (Yb-Ye)*4*10**-3)
    limit = c.create_line((0, h-Ya), (constant, h-Ya), dash=(5, 1), fill="red", activefill="black")
    c1 = c.create_oval((X1+5, h-(Y1+5)), (X1-5, h-(Y1-5)), fill="yellow", outline="white", activeoutline="black", width=2)
    c2 = c.create_oval((Xb+5, h-(Yb+5)), (Xb-5, h-(Yb-5)), fill="yellow", outline="white", activeoutline="black", width=2)
    c3 = c.create_oval((Xe+5, h-(Ye+5)), (Xe-5, h-(Ye-5)), fill="yellow", outline="white", activeoutline="black", width=2)
    c4 = c.create_oval((X2+5, h-(Y2+5)), (X2-5, h-(Y2-5)), fill="yellow", outline="white", activeoutline="black", width=2)
    c.create_text(constant+(w-constant)/2, h-h/2, text="", font=(".keyboard", 20), tag="text")
    c.create_text(constant+(w-constant)/2, h-h/2-h/4, text="", font=(".keyboard", 20), tag="square")
    c.create_text(constant+(w-constant)/2, h-h/2+h/4, text="", font=(".keyboard", 20), tag="coord")
    c.pack(fill=BOTH, expand=1)

    c.tag_bind(rect1, "<Enter>", lambda event: c.itemconfig("square", text=f"{W}x{H}\nПлоща безпечної\nзони\n{W*H} кв.од"))
    c.tag_bind(rect1, "<Leave>", lambda event: c.itemconfig("square", text=""))
    c.tag_bind(rect2, "<Enter>", lambda event: c.itemconfig("square", text=f"{W}x{H}\nПлоща безпечної\nзони\n{W*H} кв.од"))
    c.tag_bind(rect2, "<Leave>", lambda event: c.itemconfig("square", text=""))
    c.tag_bind(rect3, "<Enter>", lambda event: c.itemconfig("square", text=f"{W}x{H}\nПлоща безпечної\nзони\n{W*H} кв.од"))
    c.tag_bind(rect3, "<Leave>", lambda event: c.itemconfig("square", text=""))
    c.tag_bind(limit, "<Enter>", lambda event: c.itemconfig("coord", text=f"Максимальна безпечна\nвисота {Ya}"))
    c.tag_bind(limit, "<Leave>", lambda event: c.itemconfig("coord", text=""))
    c.tag_bind(c1, "<Enter>", lambda event: c.itemconfig("coord", text=f"(X1;Y1)\n{X1};{Y1}"))
    c.tag_bind(c1, "<Leave>", lambda event: c.itemconfig("coord", text=""))
    c.tag_bind(c2, "<Enter>", lambda event: c.itemconfig("coord", text=f"(Xb;Yb)\n{Xb};{Yb}"))
    c.tag_bind(c2, "<Leave>", lambda event: c.itemconfig("coord", text=""))
    c.tag_bind(c3, "<Enter>", lambda event: c.itemconfig("coord", text=f"(Xe;Ye)\n{Xe};{Ye}"))
    c.tag_bind(c3, "<Leave>", lambda event: c.itemconfig("coord", text=""))
    c.tag_bind(c4, "<Enter>", lambda event: c.itemconfig("coord", text=f"(X2;Y2)\n{X2};{Y2}"))
    c.tag_bind(c4, "<Leave>", lambda event: c.itemconfig("coord", text=""))
    
    c.bind("<Button-1>", PrintCoords)
    c.bind("<Button-3>", lambda event: RM.post(event.x_root, event.y_root))
    picture.mainloop()

def DestroyPicture():
    global picture
    try:
        picture.destroy()
    except:
        pass

def DATAEXAMPLE():
    ENTYa.delete(0, END)
    ENTX1Y1.delete(0, END)
    ENTXbYb.delete(0, END)
    ENTXeYe.delete(0, END)
    ENTX2Y2.delete(0, END)
    ENTWH.delete(0, END)
    ENTYa.insert(0, "360")
    ENTX1Y1.insert(0, "200 240")
    ENTXbYb.insert(0, "350 240")
    ENTXeYe.insert(0, "600 100")
    ENTX2Y2.insert(0, "750 240")
    ENTWH.insert(0, "150 60")

def EVAL():
    message = ""
    left = "red"
    right = "red"
    under = "red"
    try:
        Ya = int(ENTYa.get())
        X1, Y1 = list(map(int, ENTX1Y1.get().split()))
        Xb, Yb = list(map(int, ENTXbYb.get().split()))
        Xe, Ye = list(map(int, ENTXeYe.get().split()))
        X2, Y2 = list(map(int, ENTX2Y2.get().split()))
        W, H = list(map(int, ENTWH.get().split()))
        constant = X2 + X1
        
        if (X1 - W > 0) and (Ya - Y1 > H):#над мостом зліва
            left = "lightgreen"
            message += f"Можна пролетіти над мостом зліва: ({X1/2};{Y1 + (Ya-Y1)/2})\n"
        if (Ya - Y2 > H):#над мостом справа
            right = "lightgreen"
            message += f"Можна пролетіти над мостом справа: ({X2 + (constant-X2)/2};{Y2+ (Ya-Y2)/2})\n"
        if (Ya > Ye + (Yb - Ye)/2 + H/2) and  (Yb > Ye + (Yb - Ye)/2 + H/2) and (Xb + W < Xe):#під мостом
            under = "lightgreen" 
            message += f"Можна пролетіти під мостом:({Xb + (Xe - Xb)/2};{Ye + (Yb - Ye)/2})"
        if message == "":
            message = "На жаль, рекомендацій по шляху немає."
        showinfo("Рекомендації", message)
        DestroyPicture()
        CreatePicture(X1, Y1, Xb, Yb, Xe, Ye, X2, Y2, W, H, Ya, left, right, under)
    except:
        showerror("Сталася помилка!", "Ви ввели недопустиме значення!")

def CLEARALL():
    ENTYa.delete(0, END)
    ENTX1Y1.delete(0, END)
    ENTXbYb.delete(0, END)
    ENTXeYe.delete(0, END)
    ENTX2Y2.delete(0, END)
    ENTWH.delete(0, END)


Window = Tk()
Window.focus()
Window.title("Вікно вхідних даних задачі")

F = LabelFrame(Window, text = 'ПРОЄКТ "БОЙОВИЙ ГВИНТОКРИЛ"', font = ("Times", 14, "bold"), labelanchor = "n")

LABTITLE = Label(F, text = "Координати x, y вводяться через пробіл!", font="Bold").grid(row = 0, column = 0, columnspan = 2)

LABYa = Label(F, text = "Координата макс. безпечної висоти Ya:").grid(row = 1, column = 0, pady = 10, padx = 10, sticky = E)
LABX1Y1 = Label(F, text = "Координати лівого краю моста X1, Y1:").grid(row = 2, column = 0, pady = 10, padx = 10, sticky = E)
LABXbYb = Label(F, text = "Координати моста Xb, Yb:").grid(row = 3, column = 0, pady = 10, padx = 10, sticky = E)
LABXeYe = Label(F, text = "Координати землі Xe, Ye:").grid(row = 4, column = 0, pady = 10, padx = 10, sticky = E)
LABX2Y2 = Label(F, text = "Координати правого краю моста X2, Y2:").grid(row = 5, column = 0, pady = 10, padx = 10, sticky = E)
LABWH = Label(F, text = "Ширина і висота поля  W, H:").grid(row = 6, column = 0, pady = 10, padx = 10, sticky = E)

ENTYa = Entry(F, width = 22)
ENTYa.insert(0, "0")
ENTX1Y1 = Entry(F, width = 22)
ENTX1Y1.insert(0, "0 0")
ENTXbYb = Entry(F, width = 22)
ENTXbYb.insert(0, "0 0")
ENTXeYe = Entry(F, width = 22)
ENTXeYe.insert(0, "0 0")
ENTX2Y2 = Entry(F, width = 22)
ENTX2Y2.insert(0, "0 0")
ENTWH = Entry(F, width = 22)
ENTWH.insert(0, "0 0")

ENTYa.grid(row = 1, column = 1, pady = 10, padx = 10)
ENTX1Y1.grid(row = 2, column = 1, pady = 10, padx = 10)
ENTXbYb.grid(row = 3, column = 1, pady = 10, padx = 10)
ENTXeYe.grid(row = 4, column = 1, pady = 10, padx = 10)
ENTX2Y2.grid(row = 5, column = 1, pady = 10, padx = 10)
ENTWH.grid(row = 6, column = 1, pady = 10, padx = 10)


BUT1 = Button(F, text = "Результат", width = 22, command = EVAL)
BUT1.grid(row = 8, sticky = SW)
BUT2 = Button(F, text = "Очистити поля", width = 22, command = CLEARALL)
BUT2.grid(row = 7, column = 0, sticky = SW)
BUT3 = Button(F, text = "Детальніше про проєкт", width = 22, command = lambda: open_new("https://drive.google.com/file/d/1-MsFejNgq8smBRzNbeuYd4SR41UWCgvi/view?usp=sharing"))
BUT3.grid(row = 8, column = 1, sticky = SE)
BUT4 = Button(F, text = "Контрольний приклад", width = 22, command = DATAEXAMPLE)
BUT4.grid(row = 7, column = 1, sticky = SE)

B = Balloon(initwait = 300)
B.bind_widget(BUT1, balloonmsg = "Нажміть щоб отримати рекомендації")

B2 = Balloon(initwait = 300)
B2.bind_widget(BUT4, balloonmsg = "Задає координати для наглядного прикладу")

B3 = Balloon(initwait = 300)
B3.bind_widget(BUT2, balloonmsg = "Очищує координати полей Entry")

B4 = Balloon(initwait = 300)
B4.bind_widget(BUT3, balloonmsg = "Постановка задачі.pdf")

F.pack()

Window.mainloop()
