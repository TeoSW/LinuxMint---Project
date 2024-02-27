    #!/bin/bash
    #Constantin Teodor Vasile - Grupa 1029
    #Proiect G

    #Functii cerintele 1-4


    cerinta_1()
    {
    echo "Ai ales cerinta 1."

    echo -n "Introdu fiserul: "
    read numefis

    echo -n "Introdu stringul: "
    read string

    sed -i "/$string/d" "$numefis" #sterge toate liniile din fisier pe care apare acel string

    echo "Liniile au fost sterse"
    }

    cerinta_2()
    {
    echo "Ai ales cerinta 2."

    if ping -q -c 1 www.google.ro >/dev/null; then #verificare retea net prin ping-ul www.google.ro
    echo "Conexiune disponibila. Introdu link-ul: "
    read link
    wget "$link" #descarcare link
    else 
    echo "Conexiune indisponibila"	
    fi
    }


    cerinta_3()
    {
    echo "Ai ales cerinta 3."
    echo -n "Introdu numele noului utilizator: "
    read username

    #verificare existenta

    if id "$username" >/dev/null 2>&1; then 
    echo "Utilizatorul '$username' deja exista"
    exit 1
    fi

    #creare director pentru noul utilizator:
	
    home_dir="/home/$username/home"

    #adaugare utilizator si cerere parola

    useradd -m "$username"
	
    echo -n "Introdu parola: "
    read password

    echo -n "$username:$password" | chpasswd

    echo "Utilizatorul '$username' a fost adaugat"	
    }

    cerinta_4()
    {
    echo "Ai ales cerinta 4."

    echo -n "Introdu numele utilizatorului pe care doresti sa-l stergi: "
    read username

    #verificare existenta 

    if ! id "$username" >/dev/null 2>&1; then
    echo "Nu exista."
    exit 1
    fi

    #intreaba daca doreste stergerea home-ului sau

    echo "Doresti si stergerea home-ului utilizatorului?(1/0)"
    read delete

    if [ "$delete" = '1' ]; then
    userdel -r "$username"
    elif [ "$delete" = '0' ]; then
    userdel "$username"
    else echo "Eroare."
    fi
    echo -n "Utilizatorul "$username" a fost sters"
    }

    #Ce face scriptul
    echo "Scriptul realizeaza:"
    echo "1. Cere de la tastatura numele unui fisier si un sir. Sterge toate liniile date din acel fisier"
    echo "2. Descarca un link de la tastatura si verifica conexiunea la net"
    echo "3. Adauga un nou utilizator (se creaza automat un home si se cere schimbarea parolei)"
    echo "4. Sterge un utilizator si intreaba daca se doreste stergerea home-ului sau"

    #verificarea root & daca rootul este egal cu 0 (pentru a evita eroarea illegal number)
    EUID=$(id -u)
    if [ "$EUID" -ne -0 ]; then
    echo "Scriptul necesita privilegii de root. Ruleaza scriptul folosind sudo"
    exit 1;
    fi

    #rulare subpunct ales
    echo "Introdu subpunctul ce vrei sa fie rulat.(1/2/3/4)"
    read numar
    case $numar in
    1)
    cerinta_1
    ;;
    2)
    cerinta_2
    ;;
    3)
    cerinta_3
    ;;
    4)
    cerinta_4
    ;;
    *)
    echo "Eroare."
    exit 1
    ;;
    esac
