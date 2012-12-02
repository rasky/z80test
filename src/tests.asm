
selftests   equ     0

mem         equ     data.mem
memlo       equ     mem%256
memhi       equ     mem/256
memsp       equ     mem+2

testtable:
            if      selftests
            dw      .crc
            dw      .counter
            dw      .shifter
            endif

            dw      .selftest

            dw      .ld_r_r
            dw      .ld_x_x
            dw      .ld_r_xyd
            dw      .ld_xyd_r
            dw      .ld_r_n

            dw      0

            include testmacros.asm

            ; test vectors themselves.

            if 0
            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    ""
            endif

            if      selftests

.crc        flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
;           crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            crcs    allflags,0x00ffffff,all,0x2e26825b,docflags,0x354a5705,doc,0x4a0a6669
            name    "CRC TEST"

.counter    flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x01,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x8000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0x00000000,all,0x65283e9d,docflags,0x3b3096d9,doc,0x70844659
            name    "COUNTER TEST"

.shifter    flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x41,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x8000
            crcs    allflags,0x00000000,all,0xd690f8ac,docflags,0x3b3096d9,doc,0xc33c8068
            name    "SHIFTER TEST"

            endif

.selftest   flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x20,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x08,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xf3b489a6,all,0x1052d099,docflags,0x3b3096d9,doc,0x48e530ef
            name    "SELF TEST"

.ld_r_r     flags   s,1,z,1,f5,1,hc,1,f3,1,pv,1,n,1,c,1
            vec     0x40,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,mem   ,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x3f,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x8001,a,0x01,f,0xff,bc,0x8001,de,0x8001,hl,0x0001,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    "LD [R,(HL)],[R,(HL)]"

.ld_x_x     flags   s,1,z,1,f5,1,hc,1,f3,1,pv,1,n,1,c,1
            vec     0xdd,0x40,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,mem   ,iy,mem   ,sp,0xc000
            vec     0x20,0x3f,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x8001,a,0x01,f,0xff,bc,0x8001,de,0x8001,hl,0x8001,ix,0x0001,iy,0x0001,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    "LD [X,(XY)],[X,(XY)]"

.ld_r_xyd   flags   s,1,z,1,f5,1,hc,1,f3,1,pv,1,n,1,c,1
            vec     0xdd,0x46,-128,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,mem+128,iy,mem+128,sp,0xc000
            vec     0x20,0x38,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x01,0x00,mem,0x8001,a,0x01,f,0xff,bc,0x8001,de,0x8001,hl,0x8001,ix,0x0001,iy,0x0001,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    "LD R,(XY)"

.ld_xyd_r   flags   s,1,z,1,f5,1,hc,1,f3,1,pv,1,n,1,c,1
            vec     0xdd,0x70,+126,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,mem-126,iy,mem-126,sp,0xc000
            vec     0x20,0x07,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x01,0x00,mem,0x8001,a,0x01,f,0xff,bc,0x8001,de,0x8001,hl,0x8001,ix,0x0001,iy,0x0001,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    "LD (XY),R"

.ld_r_n     flags   s,1,z,1,f5,1,hc,1,f3,1,pv,1,n,1,c,1
            vec     0x06,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,mem   ,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x38,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0xff,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    "LD [R,(HL)],N"

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

            flags   s,1,z,1,f5,0,hc,1,f3,0,pv,1,n,1,c,1
            vec     0x00,0x00,0x00,0x00,mem,0x1234,a,0xaa,f,0xff,bc,0xbbcc,de,0xddee,hl,0x4411,ix,0xdd88,iy,0xfd77,sp,0xc000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            vec     0x00,0x00,0x00,0x00,mem,0x0000,a,0x00,f,0x00,bc,0x0000,de,0x0000,hl,0x0000,ix,0x0000,iy,0x0000,sp,0x0000
            crcs    allflags,0xaf0f0011,all,0xac0f0022,docflags,0xdf0f0033,doc,0xdc0f0044
            name    " "

