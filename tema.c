#include<stdio.h>
#include<string.h>

int main(){
    char s[1847] = "gycyicky s xcicqhctgi.tckgcwgdzcqcds kkzcfg.tc .tfilyck bkci.cgse scugsikckgcr clkqkilkiwqffzcs f jq.kcugsckyilckqlpcq.ecyqj cky cdsgd scf kk sceilksirmkig.xky l cqs ckngcguchzcuqjgsik cv .cpgq.lcugscdsgtsqhh slxczgmcwq.cui.echgs cqkcky wge f llwge xwghxc .ogzxuislkcg. xcqc.gjiw clkmei ecky coqjqchqlk slcwge cq.ecqegdk ecky chqlk slclkzf ckgcq.c bqwki.tce ts  xky ce lit.cdqkk s.lc hdfgz ecky c.qhi.tcwg.j .kig.lcugscjqsiqrf lcky c.mhr scguldqw lcml eckgci.e .kc qwyc. lk ecrfgwpxc j .cky cwghh .klcn s cnsikk .ci.cq.ihds llij cihikqkig.cgucky chqlk slcgn.cjgiw xcemsi.tcyilc. bkcwge cs ji ncky .gjiw cnqlclmsdsil eckgcui.ecky coqjqchqlk scks h .egmlfzceildf ql excrmkchqlk scdsgk lk ecky clkme .kxicyqj cugffgn eczgmsc bqhdf cegn.ckgcky cui.qfcl hiwgfg.xcl  cy s cilcqcmkifikzwfqllczgmcnsgk cg.fzcfqlkchg.kyxcilcikc.gkcqlcfip ckgchzcgn.cwge cqlckngc ttlusghcky clqh cwfmkwyxcq.ecky s i.cfi lcky cdsgrf hclwgnf ecky chqlk sxcz lk seqzcicnqlcqcuggfky cn  pcr ugs cq.cieigkcq.ecfqlkchg.kycq.cihr wif xceg.kclygnch cwge cichitykyqj cnsikk .cz lk seqzxclygnch cwge cqlcicniffcnsik cikckghgssgnxl wg.ecg. xcky c.m.clqkgmcqddsgqwy echqlk scpqihmcq.eclqiechzchqlk scldgp cgucquislkchq.ksqcnyiwychmlkctmie cky ckygmtyklcguck hdf ce j fgd slcqkcqffckih lxcnyqkcilckyilchq.ksqxpqihmcq.ln s ecicws qk xcky c ll .w cguce j fgd sc.qkms cilckgcr cqfnqzlci.cky dsgw llcgucws qkig.cny .cg. cilcqkcqcp zrgqsexclqkgmcqswy ecq.c z rsgnclmldiwigmlfzq.ecqlp eciucich s fzcuibce u wklcnyqkcqhcicws qki.txcpqihmcq.ln s ecyqshg.zxlqkgmcqlp eciucics uqwkgscz kcds l sj cr yqjigscnyqkcqhcicws qki.txpqihmcq.ln s ecgse sxlqkgmcqlp eciucice f k cq.cm.ml ecdsgo wkcnyqkcqhcicws qki.txpqihmcq.ln s eceilpcldqw xlqkgmcqlp eciucicegc.gkyi.tcrmkcrsgnl cky cn rcnyqkcqhcicws qki.txpqihmcq.ln s echill ece qefi. lcq.ecqcogrcgd .i.txkyqkcilcqffxcwg.tsqkmfqkig.lcg.cqcogrcn ffceg. ";

    int i;
    for(i = 0; i < strlen(s); i++){
        if(s[i] == 'a')              s[i] = 'q';
        else if(s[i] == 'b')         s[i] = 'x';
        else if(s[i] == 'c')         s[i] = ' ';
        else if(s[i] == 'd')         s[i] = 'p';
        else if(s[i] == 'e')         s[i] = 'd';
        else if(s[i] == 'f')         s[i] = 'l';
        else if(s[i] == 'g')         s[i] = 'o';
        else if(s[i] == 'h')         s[i] = 'm';
        else if(s[i] == 'i')         s[i] = 'i';
        else if(s[i] == 'j')         s[i] = 'v';
        else if(s[i] == 'k')         s[i] = 't';
        else if(s[i] == 'l')         s[i] = 's';
        else if(s[i] == 'm')         s[i] = 'u';
        else if(s[i] == 'n')         s[i] = 'w';
        else if(s[i] == 'o')         s[i] = 'j';
        else if(s[i] == 'p')         s[i] = 'k';
        else if(s[i] == 'q')         s[i] = 'a';
        else if(s[i] == 'r')         s[i] = 'b';
        else if(s[i] == 's')         s[i] = 'r';
        else if(s[i] == 't')         s[i] = 'g';
        else if(s[i] == 'u')         s[i] = 'f';
        else if(s[i] == 'v')         s[i] = 'z';
        else if(s[i] == 'w')         s[i] = 'c';
        else if(s[i] == 'x')         s[i] = '.';
        else if(s[i] == 'y')         s[i] = 'h';
        else if(s[i] == 'z')         s[i] = 'y';
        else if(s[i] == '.')         s[i] = 'n';
        else if(s[i] == ' ')         s[i] = 'e';

    }

    printf("%s\n\n", s);
return 0;
}
