insert into public.postopki (koda, naziv, opis, vrstni_red)
values
    (
        'prvo_dovoljenje',
        '{"sl":"Prvo dovoljenje za prebivanje","en":"First residence permit","sr":"Prva dozvola za boravak"}',
        '{"sl":"Pridobitev prvega dovoljenja za prebivanje.","en":"Applying for a first residence permit.","sr":"Podnošenje zahteva za prvu dozvolu za boravak."}',
        1
    ),
    (
        'podaljsanje_dovoljenja',
        '{"sl":"Podaljšanje dovoljenja za prebivanje","en":"Residence permit renewal","sr":"Produženje dozvole za boravak"}',
        '{"sl":"Podaljšanje obstoječega dovoljenja za prebivanje.","en":"Renewing an existing residence permit.","sr":"Produženje postojeće dozvole za boravak."}',
        2
    ),
    (
        'bancni_racun',
        '{"sl":"Odprtje bančnega računa","en":"Opening a bank account","sr":"Otvaranje bankovnog računa"}',
        '{"sl":"Odprtje bančnega računa v Sloveniji.","en":"Opening a bank account in Slovenia.","sr":"Otvaranje bankovnog računa u Sloveniji."}',
        3
    )
on conflict (koda) do nothing;
