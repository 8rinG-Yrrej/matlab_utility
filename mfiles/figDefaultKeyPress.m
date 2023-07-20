function figDefaultKeyPress(src,evnt)
%FIGDEFAULTKEYPRESS callback to add default MATLAB shortcuts to figure window.
%
%   figDefaultKeyPress(src,evnt) processes a WindowKeyPressFcn (a scalar struct with fields
%   "Character" "Modifier" & "Key", such that standard MATLAB short cut keys, e.g. Command+0 to reach
%   command window, work in the context of an object src which has a callback to this function.
%
%   Simple extensions to standard default key-strokes are:
%     Ctrl-Shift-W = close all figure windows (by default Ctrl-W = close this figure window)
%     Ctrl-Shift-E = close every figure window Except this one
%     Ctrl-Shift-A toggles docked state of all figures.
%     Alt+P = print to file (or you could set-up to use export_fig) (Ctrl+P is print)
%     Ctrl+D toggles dragzoom, which is a great utility from the FEX.
%     F1 produces a help dialogue to remind you the main shortcuts.
%   N.B. MATLAB needs you to press Ctrl before Shift to access these options.
%
%   Typically this function is used assigned as KeyPressFcn callback from a
%   figure window to extend MATLAB short-cuts to that key.
%
%   Examples
%     figure('KeyPressFcn', @figDefaultKeyPress); % createfigure with callback
%
%     % Put these lines in your startup.m to make this a default for all new figs
%     if ~isdeployed
%       set(0, 'DefaultFigureKeyPressFcn', @figDefaultKeyPress);  % default it
%     end
%
%   See also GRAPHICS, FIGURE,
%            http://www.mathworks.com/matlabcentral/fileexchange/29276-dragzoom-drag-and-zoom-tool
%
%
%
% Copyright (c) 2012, Julian
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
%
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.

% if strcmpi(evnt.Key, 'f1')
%   prompt = {
%     ' Command Window                   Command+0      '
%     ' Command History                  Command+1      '
%     ' Current Folder                   Command+2      '
%     ' Workspace                        Command+3      '
%     ' Profiler                         Command+5      '
%     ' Editor                           Command+Shift+0'
%     ' Variable Editor                  Command+Shift+3'
%     ' Help                             Command+Shift+5'
%     ' Print figure                     Command+P      '
%     '*Print to file                    Alt+P       '
%     ' Close this figure                Command+W      '
%     '*Close All figures                Command+Shift+W'
%     '*Close every figure Except this   Command+Shift+E'
%     '*Dock/undock All figure windows   Command+Shift+A'
%     '*Dragzoom on/off toggle state     Command+D      '
%     };
%   h = helpdlg(prompt, ['Help ' mfilename]);
%   pos = get(h, 'Position'); % we must increase width of window to accommodate all the text
%   set(h, 'Position', [pos(1:2) pos(3)*1.5 pos(4)]); %widen
%   h = findobj(h, 'Type', 'Text'); % find the underlying text (note String <> prompt exactly)
%   set(h, 'FontName', 'Lucida Console'); % use a fixed width font
%   return
% end

if isempty(evnt.Character)
  return
end
if isempty(evnt.Modifier)
  switch evnt.Key
    case 'l'
      if isequal('linear',get(gca,'XScale'))
        set(gca,'Xscale','log')
      elseif isequal('log',get(gca,'XScale'))
        set(gca,'Xscale','linear')
      end
    case 'g'
      set(gca,'XMinorGrid','on');set(gca,'YMinorGrid','on');set(gca,'ZMinorGrid','on');
  end
elseif isequal(evnt.Modifier, {'shift'})
  switch evnt.Key
    case 'l'
      if isequal('linear',get(gca,'YScale'))
        set(gca,'Yscale','log')
      elseif isequal('log',get(gca,'YScale'))
        set(gca,'Yscale','linear')
      end
  end
elseif isequal(evnt.Modifier, {'command'})
  switch evnt.Key
    case '0' % command window
      commandwindow;
    case '1' % command history
      commandhistory;
    case '2' % current folder
      filebrowser;
    case '3' % workspace browser
      workspace;
    case '4' % profiler
      profile viewer
      % case {'d' 'D'} % Command+D toggles dragzoom
      %   % see http://www.mathworks.com/matlabcentral/fileexchange/29276-dragzoom-drag-and-zoom-tool
      %   if exist('dragzoom', 'file') % dragzoom needs to be available on the path
      %     if isfield(get(src, 'UserData'), {'axesinfo' 'origcallbacks'})
      %       dragzoom off % switch off dragzoom
      %     else % TODO this is not correct right now
      %       % issues dragzoom does not toggle when used on it's own
      %       % does not remove all stuff when turned off
      %       % have not yet worked out how to tell if it is active
      %       dragzoom % without explicit status, dragzoom activates rather than toggles
      %     end
      %   end
    case 'c'
      fig2clip
  end
elseif isequal(evnt.Modifier,  {'shift' 'command'})
  switch evnt.Key
    case '0' % Shift+Command+0 switches to the MATLAB editor
      if verLessThan('matlab', '7.12.0.635') % prior to release R2011a
        try
          % see http://blogs.mathworks.com/desktop/2009/10/26/the-matlab-editor-at-your-fingertips/
          % also of interest there is a COM editor API
          % com.mathworks.mlservices.MLEditorServices
          edoc = editorservices.getActive; % N.B. since deprecated experimental API under development
          edoc.makeActive;
        catch % editorservices not available when editor not running
        end
      elseif matlab.desktop.editor.isEditorAvailable && ~isempty(matlab.desktop.editor.getActive)
        % type "help matlab.desktop.editor" for info (not documented in help.browser doc)
        matlab.desktop.editor.openDocument(matlab.desktop.editor.getActiveFilename);
      end
    case '3'   % Shift+Command+3 switches to the variable editor
      openvar ans % not quite the same as bringing Variable editor into focus
      % but openvar must have an argument, and ans seems the best random choice!
    case '5'   % Shift+Command+5 switches to the Help doc window
      % using DOC or HELPBROWSER just goes to help home-page
      % whereas this has affect of switching to Help window
      helper=com.mathworks.mlservices.MLHelpServices;
      helper.setCurrentLocation(helper.getCurrentLocation);
    case 'w' % close all figure windows
      fq('all')
    case 'a' % dock/undoc (a=) All figure windows
      STYLES = { 'normal' 'docked' }; % styles to toggle between, of possible: [ {normal} | modal | docked ]
      f = strcmpi( get(src, 'WindowStyle'), STYLES); % logical index to STYLES for current state
      if isempty(f), return; end % case-of modal window - haven't thought about this
      set(findall(0, 'Type', 'figure', 'WindowStyle', STYLES{f}), 'WindowStyle', STYLES{~f}); % toggle
      desk = com.mathworks.mde.desk.MLDesktop.getInstance; % this is going off-piste here
      % for more info see http://www.mathworks.com/matlabcentral/fileexchange/16650
      % and http://blogs.mathworks.com/desktop/2007/05/18/do-you-dock-figure-windows-what-does-your-desktop-look-like/
      pause(.5); % this seems to be needed
      desk.setGroupDocked('Figures', 0); % we undock the Figures container from the desktop
    case 'f' % Command+Shift+F starts file finder
      system('open .');
    case 'e' % Command+Shift+E - close Every figure window Except this one
      fq( setdiff(findall(0, 'Type', 'figure'), src));
      % note that this is available by right-clicking tab of docked figures
    case 'n'
      copy(gcf);
    case 'l'
      logticks_ensure_dec(allaxes);
  end
elseif isequal(evnt.Modifier,  {'alt'})
  switch evnt.Key
    %{
    case 'p'
      % Make Alt+P = "print to file" for ease of emailing
      fileName = get(gcf, 'FileName');
      if isempty(fileName)
        fileName = sprintf('Figure%d', gcf); % Note we generate a Figure name (without checking Name property)
      else
        [~, fileName] = fileparts(fileName); % without leading path and extension
      end
      print2 = [fileparts(userpath) '/My Pictures/']; % where we create the "printed" file
      FORMAT = 'png'; % graphics format to use
      % fileName = fullfile(fileparts(userpath), 'My Pictures', fileName);
      fileName = [fileName '.' FORMAT];
      print(['-d' FORMAT], '-r0', [print2 fileName]); % create graphics file at full screen resolution
      msg =    { '"Printed" to %s:'
        ' <a href="matlab:winopen(''%s'')">Open</a>'
        ' <a href="matlab:winopen(''%s'')">Locate</a>\n'};
      fprintf(1, [msg{:}], fileName, [print2 fileName], print2);
      % TODO tidy up these files that are Printed To My Pictures for, say, emailing.
      % suggestions (1) log files so generated in MAT index file in My Pictures, for delete on startup or
      % exit (2) directory scan contenders using imfinfo to find those which were written by MATLAB then
      % delete these...
    %}
    case 'l'
      if isequal('linear',get(gca,'ZScale'))
        set(gca,'Zscale','log')
      elseif isequal('log',get(gca,'ZScale'))
        set(gca,'Zscale','linear')
      end
  end
elseif isequal(evnt.Modifier,  {'alt' 'command'})
  switch evnt.Key
    case 'l'
      logticks_ensure_dec
  end
elseif isequal(evnt.Modifier,  {'shift' 'alt'})
  switch evnt.Key
    case 'l'
      xticks auto
      yticks auto
      zticks auto
  end
end

end

function fq(h)
if nargin == 0
  h = gcf;
elseif strcmp(h,'all')
  h = get(groot,'Children');
end

if isscalar(h)
  clf(h);
  close(h);
else
  arrayfun(fq(h));
end

end

