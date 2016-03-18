# VLC-cutter

**VLC-cutter** is an __Bash Shell Automator Action__ created in Xcode.  
This tool is designed to cut a video from a start time to an end time plus
padding time so the glitches can be trimmed out when editing to video.  

# About Me

I'm Karl, a Rigger and AV Technician by trade working full time for an international
Audio Visual Company; coding is one of my Hobbies.  You can follow me on Twitter
__@SalamCast__ for my occasional tweets about technology and Islaam

### The interface

has 5 inputs on the Automator interface:

- Video File (VLC supported file)
- Start Time (seconds or min:sec format)
- End Time (seconds or min:sec format)
- Pad Time (seconds)
- Save Path (defaults to the users desktop)

### Action Input

This action will accept a list of times to cut in a simple "[min:sec|sec] [min:sec|sec]\n"
format for indicating the start and finish of each clip to be made from the selected
Video file.

```
120 220
4:30 12:30
```

### Automator Action Info for Scripters

The guides and tutorials I looked into were dated, but still workout; you just
need to pay attention to some of the details that are mentioned.  
I'm using Mac OS X 10.11.3, I think these guides are for Snow Leopard (10.6)

- [Shell Automator Action](https://macosxautomation.com/automator/shellacaction/index.html) [Dated]
- [Creating Shell Script Actions](https://developer.apple.com/library/mac/documentation/AppleApplications/Conceptual/AutomatorConcepts/Articles/ShellScriptActions.html#//apple_ref/doc/uid/TP40002078-BCIBAEAC) [Dated]
