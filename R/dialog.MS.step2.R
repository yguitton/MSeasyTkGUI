# MSeasy Tcl/Tk GUI for some basic functions in the MSeasy package.
# Part of the code is based on the ade4TkGUI package by Jean Thioulouse <jthioulouse@biomserv.univ-lyon1.fr>, Stephane
#       Dray <dray@biomserv.univ-lyon1.fr>
#
dialog.MS.step2 <-
function()
{
	tf <- tktoplevel()
	tkwm.title(tf,"Step2- Mass spectra clustering ")
	
	done <- tclVar(0)
	sepVar <- tclVar(1)
	

	
	
	"choosefic" <- function()
	{	
		
		sep <- tclvalue(sepVar)
		if (sep == 1) sepch <- "clust"
		if (sep == 2) sepch <- "test.clust"
	
		

			rdcom <- paste("dialog.MS.", sepch, "()",sep="")
		
			eval(parse(text=rdcom), envir=as.environment("e1"))
		tkdestroy(tf)
		
	}
	
	frame1 <- tkframe(tf, relief="groove", borderwidth=2)
	labh <- tklabel(frame1, bitmap="questhead")
	tkbind(labh, "<Button-1>", function() print(help("MS.DataCreation")))
	tkgrid(tklabel(frame1,text="Step2- Mas spectra clustering", font="Times 18", foreground="red"), labh, columnspan=2)
	tkpack(frame1, fill = "x")

		
	sepFrame <- tkframe(tf, relief="groove", borderwidth=2)
    tkgrid(tklabel(sepFrame, text="Options:", foreground="blue"))
    tkgrid(tkradiobutton(sepFrame, text="MS.clust", value=1, variable=sepVar), sticky="w")
    tkgrid(tkradiobutton(sepFrame, text="MS.test.clust", value=2, variable=sepVar), sticky="w")
    
	tkpack(sepFrame, fill = "x")
	
    


	ok.but <- tkbutton(tf, text="Submit", command=function() choosefic())
	cancel.but <- tkbutton(tf, text="Cancel", command=function() tkdestroy(tf))
	tkpack(cancel.but, ok.but, side="left", fill="x", expand=1)

	tkbind(tf, "<Destroy>", function() tclvalue(done) <- 2)
	tkbind(tf, "<KeyPress-Return>", function() choosefic())
	tkbind(tf, "<KeyPress-Escape>", function() tkdestroy(tf))
	tkwait.variable(done)
	if(tclvalue(done) == "2") return(0)
	tkdestroy(tf)
}

