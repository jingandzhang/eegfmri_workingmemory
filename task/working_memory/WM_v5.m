classdef WM_v5 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        main_label                   matlab.ui.control.Label
        StartButton                  matlab.ui.control.Button
        State_label                  matlab.ui.control.Label
        timerLabel                   matlab.ui.control.Label
        SubjectIDEditFieldLabel      matlab.ui.control.Label
        SubjectIDEditField           matlab.ui.control.EditField
        GenerateSequencesButton      matlab.ui.control.Button
        TaskfontsizeEditFieldLabel   matlab.ui.control.Label
        TaskfontsizeEditField        matlab.ui.control.NumericEditField
        IntrofontsizeEditFieldLabel  matlab.ui.control.Label
        IntrofontsizeEditField       matlab.ui.control.NumericEditField
        SeqDirEditFieldLabel         matlab.ui.control.Label
        SeqDirEditField              matlab.ui.control.EditField
        ChooseButton                 matlab.ui.control.Button
        Task_size_text               matlab.ui.control.Label
        intro_size_text              matlab.ui.control.Label
    end

    
    properties (Access = public)
        keys={}; % acquired keys
        seq_number=0;
        responces=[];
        subject='999_V1_S1_R1';
        N_seq=0;
        TR=2.24;
        Seq_dir=''; % Description
        Task_font_size=60; % Description
        Intro_font_size=25; % Description
        Lets_start=false; % Description
        TIMES={};
        Main_time=[];
        
        equation_time=3;
        letter_time=1;
        response_time=3;
        
    end
    
    
    methods (Access = public)
        
        
        function start_seq(app)
            while(1)
                drawnow
                
                if app.Lets_start
                    app.Main_time(1,:)=clock;
                    app.main_label.Text=' ';
                    drawnow
                    pause(4*app.TR-2)
                    app.main_label.Text='+';
                    drawnow
                    pause(2)
                    
                    for seq=1:app.N_seq
                        app.TIMES{seq}=[];
                        
                        tab = readtable([app.Seq_dir '/OSPAN_' num2str(seq) '.csv']);
                        app.State_label.Text='sequence and get key';
                        app.Main_time(seq*2,:)=clock;
                        app.TIMES{seq}=[app.TIMES{seq}; clock];
                        app.responces.OSPAN_equ{seq}=present_get_key(app,tab);
                        app.TIMES{seq}=[app.TIMES{seq}; clock];
                        
                        tab = readtable([app.Seq_dir '/OSPAN_' num2str(seq) '.csv']);
                        app.TIMES{seq}=[app.TIMES{seq}; clock];
                        app.responces.OSPAN_letter{seq}=OSPAN_test(app,tab);
                        app.TIMES{seq}=[app.TIMES{seq}; clock];
                        
                        tab = readtable([app.Seq_dir '/Baseline_' num2str(seq*2-1) '.csv']);
                        app.State_label.Text='sequence and get key';
                        app.TIMES{seq}=[app.TIMES{seq}; clock];
                        app.responces.Baseline{seq*2-1}=present_get_key(app,tab);
                        app.TIMES{seq}=[app.TIMES{seq}; clock];
                        
                        tab = readtable([app.Seq_dir '/Arithmetic_' num2str(seq) '.csv']);
                        app.State_label.Text='sequence and get key';
                        app.TIMES{seq}=[app.TIMES{seq}; clock];
                        app.responces.Arithmetic{seq}=present_get_key(app,tab);
                        app.TIMES{seq}=[app.TIMES{seq}; clock];
                        
                        tab = readtable([app.Seq_dir '/Baseline_' num2str(seq*2) '.csv']);
                        app.State_label.Text='sequence and get key';
                        app.TIMES{seq}=[app.TIMES{seq}; clock];
                        app.responces.Baseline{seq*2}=present_get_key(app,tab);
                        app.TIMES{seq}=[app.TIMES{seq}; clock];
                        app.Main_time(seq*2+1,:)=clock;
                    end
                    app.TIMES{app.N_seq+1}=[];
                    tab = readtable([app.Seq_dir '/OSPAN_' num2str(app.N_seq+1) '.csv']);
                    app.State_label.Text='sequence and get key';
                    app.Main_time((app.N_seq+1)*2,:)=clock;
                    app.TIMES{app.N_seq+1}=[app.TIMES{app.N_seq+1}; clock];
                    app.responces.OSPAN_equ{app.N_seq+1}=present_get_key(app,tab);
                    app.TIMES{app.N_seq+1}=[app.TIMES{app.N_seq+1}; clock];
                    
                    tab = readtable([app.Seq_dir '/OSPAN_' num2str(app.N_seq+1) '.csv']);
                    app.TIMES{app.N_seq+1}=[app.TIMES{app.N_seq+1}; clock];
                    app.responces.OSPAN_letter{app.N_seq+1}=OSPAN_test(app,tab);
                    app.TIMES{app.N_seq+1}=[app.TIMES{app.N_seq+1}; clock];
                    app.Main_time((app.N_seq+1)*2+1,:)=clock;
                    
                    
                    
                    
                    responses=app.responces;
                    Times=app.TIMES;
                    Main_time=app.Main_time;
                    save(['responces_' app.subject  '.mat'],'responses','Times','Main_time')
                    app.Lets_start=false;
                    break
                end
                
            end
            
            close
        end
        function out=present_get_key(app,tab)
            app.keys={};
            for i=1:size(tab,1)
                app.State_label.Text='sequence and get key';
                app.seq_number=i;
                app.main_label.Text=tab.Equations(i);
                app.timerLabel.Text=num2str(0);
                drawnow
                tic
                %app.UIFigure.CurrentCharacter=char(' ');
                while(toc<app.equation_time)
                    drawnow
                    if str2num(app.timerLabel.Text)~=floor(toc)
                        app.timerLabel.Text=num2str(int16(floor(toc)));
                        
                        drawnow
                    end
                end
                %out{i}=app.UIFigure.CurrentCharacter;
                app.State_label.Text='leter and dont get key';
                app.main_label.Text=tab.Letters(i);
                app.timerLabel.Text=num2str(0);
                drawnow
                tic
                
                while(toc<app.letter_time)
                    if str2num(app.timerLabel.Text)~=floor(toc)
                        app.timerLabel.Text=num2str(int16(floor(toc)));
                        drawnow
                    end
                end
                
            end
            out=app.keys;
        end
        function out=OSPAN_test(app,tab)
            app.keys={};
            for i=1:size(tab,1)
                app.keys{i,1}='';
                app.keys{i,2}=0;
                app.State_label.Text='sequence and get key';
                app.seq_number=i;
                temp=tab.Letters(i);
                let_set=letter_set(app,temp{1});
                app.main_label.Text=let_set;
                app.timerLabel.Text=num2str(0);
                drawnow
                tic
                
                %app.UIFigure.CurrentCharacter=char(' ');
                while(toc<app.response_time)
                    drawnow
                    if str2num(app.timerLabel.Text)~=floor(toc)
                        app.timerLabel.Text=num2str(int16(floor(toc)));
                        drawnow
                    end
                end
                %out{i}=[let_set ' ' app.UIFigure.CurrentCharacter];
                app.keys{i,1}=[let_set ' ' app.keys{i,1}];
            end
            out=app.keys;
            
        end
        function out=letter_set(app,letter)
            letters='BCDFGHJKLMNPQRTVWYZ';
            letters(strfind(letters,letter))=[];
            ind = randperm(length(letters),4);
            out=letters(ind);
            out(randi(4))=letter;
            out=[out(1) '  ' out(2) '  ' out(3) '  ' out(4)];
        end
        
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, N_seq, TR)
            app.N_seq=N_seq;
            app.TR=TR;
        end

        % Button pushed function: StartButton
        function start(app, event)
            if strcmp(app.State_label.Text,'start')
                
                app.UIFigure.WindowState='fullscreen';
                app.SubjectIDEditField.delete;
                app.SubjectIDEditFieldLabel.delete;
                app.ChooseButton.delete;
                app.GenerateSequencesButton.delete;
                app.IntrofontsizeEditField.delete;
                app.TaskfontsizeEditField.delete;
                app.TaskfontsizeEditFieldLabel.delete;
                app.IntrofontsizeEditFieldLabel.delete;
                app.SeqDirEditField.delete;
                app.SeqDirEditFieldLabel.delete;
                app.Task_size_text.delete;
                app.intro_size_text.delete;
                app.main_label.FontSize=app.Intro_font_size;
                pause(1)
                pos_temp=get(0, 'ScreenSize');
                intro=fopen('Intro.txt');
                intro=transpose(textscan(intro,'%s', 'Delimiter', '\n'));
                intro=intro{1,1};
                app.main_label.Text=intro;
                pos=app.main_label.Position;
                app.main_label.Position=[0,0,pos_temp(3),pos_temp(4)];
                app.State_label.Text='intro';
                app.StartButton.Text='Press 5';
                app.StartButton.Position=[pos_temp(3)/2-app.StartButton.Position(3)/2,pos_temp(4)/12,app.StartButton.Position(3),app.StartButton.Position(4)] ;
                drawnow
                
                start_seq(app);
                %                 app.StartButton.Enable='off';
                
            elseif strcmp(app.State_label.Text,'intro')
                app.main_label.FontSize=app.Task_font_size;
                app.StartButton.Position=[-200,-500,10,10];
                app.State_label.Text='OSPAN1_learning';
                app.Lets_start=true;
                drawnow
                
            end
        end

        % Callback function: UIFigure, UIFigure
        function UIFigureKeyPress(app, event)
            key = event.Key;
%             display(key)
            %             if (strcmp(key,'space')&&strcmp(app.State_label.Text,'start'))
            %                 start(app)
            %
            %             end
            if strcmp(key,'5')&&strcmp(app.State_label.Text,'intro')
                app.main_label.FontSize=app.Task_font_size;
                app.StartButton.Position=[-200,-500,10,10];
                app.State_label.Text='OSPAN1_learning';
                app.Lets_start=true;
                drawnow
            end
            if (strcmp(app.State_label.Text,'sequence and get key')&&(~strcmp(key,'5')))
                app.keys{app.seq_number,1}=key;
                app.keys{app.seq_number,2}=toc;
            end
            
            
        end

        % Value changed function: SubjectIDEditField
        function SubjectIDEditFieldValueChanged(app, event)
            value = app.SubjectIDEditField.Value;
            app.subject=value;
        end

        % Button pushed function: GenerateSequencesButton
        function GenerateSequencesButtonPushed(app, event)
            mkdir(app.SubjectIDEditField.Value)
            SEQ_DIR=app.SubjectIDEditField.Value;
            app.subject=SEQ_DIR;
            app.Seq_dir=SEQ_DIR;
            len_seq=7;
            N_OSPAN=app.N_seq;
            N_Arithmetic=app.N_seq;
            N_Baseline=app.N_seq*2;
            
            
            %% OSPAN
            for i=1:(N_OSPAN+1)
                tab=Generate_seq(len_seq,1,1);
                writetable(tab,[SEQ_DIR '/OSPAN_' num2str(i) '.csv'])
            end
            
            
            %% Arithmetic
            for i=1:N_Arithmetic
                tab=Generate_seq(len_seq,1,0);
                writetable(tab,[SEQ_DIR '/Arithmetic_' num2str(i) '.csv'])
            end
            
            %% Baseline
            for i=1:N_Baseline
                tab=Generate_seq(len_seq,0,0);
                writetable(tab,[SEQ_DIR '/Baseline_' num2str(i) '.csv'])
            end
            app.SeqDirEditField.Value=app.Seq_dir;
        end

        % Value changed function: SeqDirEditField
        function SeqDirEditFieldValueChanged(app, event)
            value = app.SeqDirEditField.Value;
            app.Seq_dir=value;
        end

        % Button pushed function: ChooseButton
        function ChooseButtonPushed(app, event)
            selpath = uigetdir('','Select sequences direcory');
            app.SeqDirEditField.Value=selpath;
            app.Seq_dir=selpath;
        end

        % Value changed function: TaskfontsizeEditField
        function TaskfontsizeEditFieldValueChanged(app, event)
            value = app.TaskfontsizeEditField.Value;
            app.Task_font_size=value;
            app.Task_size_text.FontSize=value;
        end

        % Value changed function: IntrofontsizeEditField
        function IntrofontsizeEditFieldValueChanged(app, event)
            value = app.IntrofontsizeEditField.Value;
            app.Intro_font_size=value;
            app.intro_size_text.FontSize=value;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.WindowKeyPressFcn = createCallbackFcn(app, @UIFigureKeyPress, true);
            app.UIFigure.KeyPressFcn = createCallbackFcn(app, @UIFigureKeyPress, true);
            app.UIFigure.Interruptible = 'off';
            app.UIFigure.HandleVisibility = 'on';

            % Create main_label
            app.main_label = uilabel(app.UIFigure);
            app.main_label.HorizontalAlignment = 'center';
            app.main_label.FontSize = 30;
            app.main_label.FontWeight = 'bold';
            app.main_label.Position = [1 433 640 40];
            app.main_label.Text = 'Woking Memory Task';

            % Create StartButton
            app.StartButton = uibutton(app.UIFigure, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @start, true);
            app.StartButton.Position = [261 10 100 22];
            app.StartButton.Text = 'Start';

            % Create State_label
            app.State_label = uilabel(app.UIFigure);
            app.State_label.FontColor = [0.9412 0.9412 0.9412];
            app.State_label.Position = [1 429 164 22];
            app.State_label.Text = 'start';

            % Create timerLabel
            app.timerLabel = uilabel(app.UIFigure);
            app.timerLabel.FontColor = [.94 .94 .94];
            app.timerLabel.Position = [1 459 33 22];
            app.timerLabel.Text = 'timer';

            % Create SubjectIDEditFieldLabel
            app.SubjectIDEditFieldLabel = uilabel(app.UIFigure);
            app.SubjectIDEditFieldLabel.HorizontalAlignment = 'right';
            app.SubjectIDEditFieldLabel.Position = [33 345 61 22];
            app.SubjectIDEditFieldLabel.Text = 'Subject ID';

            % Create SubjectIDEditField
            app.SubjectIDEditField = uieditfield(app.UIFigure, 'text');
            app.SubjectIDEditField.ValueChangedFcn = createCallbackFcn(app, @SubjectIDEditFieldValueChanged, true);
            app.SubjectIDEditField.Position = [109 345 100 22];
            app.SubjectIDEditField.Value = '999_V1_S1_R1';

            % Create GenerateSequencesButton
            app.GenerateSequencesButton = uibutton(app.UIFigure, 'push');
            app.GenerateSequencesButton.ButtonPushedFcn = createCallbackFcn(app, @GenerateSequencesButtonPushed, true);
            app.GenerateSequencesButton.FontWeight = 'bold';
            app.GenerateSequencesButton.Position = [110 299 165 31];
            app.GenerateSequencesButton.Text = 'Generate Sequences';

            % Create TaskfontsizeEditFieldLabel
            app.TaskfontsizeEditFieldLabel = uilabel(app.UIFigure);
            app.TaskfontsizeEditFieldLabel.HorizontalAlignment = 'right';
            app.TaskfontsizeEditFieldLabel.Position = [12 222 78 22];
            app.TaskfontsizeEditFieldLabel.Text = 'Task font size';

            % Create TaskfontsizeEditField
            app.TaskfontsizeEditField = uieditfield(app.UIFigure, 'numeric');
            app.TaskfontsizeEditField.ValueChangedFcn = createCallbackFcn(app, @TaskfontsizeEditFieldValueChanged, true);
            app.TaskfontsizeEditField.Position = [105 222 100 22];
            app.TaskfontsizeEditField.Value = 60;

            % Create IntrofontsizeEditFieldLabel
            app.IntrofontsizeEditFieldLabel = uilabel(app.UIFigure);
            app.IntrofontsizeEditFieldLabel.HorizontalAlignment = 'right';
            app.IntrofontsizeEditFieldLabel.Position = [324 222 78 22];
            app.IntrofontsizeEditFieldLabel.Text = 'Intro font size';

            % Create IntrofontsizeEditField
            app.IntrofontsizeEditField = uieditfield(app.UIFigure, 'numeric');
            app.IntrofontsizeEditField.ValueChangedFcn = createCallbackFcn(app, @IntrofontsizeEditFieldValueChanged, true);
            app.IntrofontsizeEditField.Position = [417 222 100 22];
            app.IntrofontsizeEditField.Value = 25;

            % Create SeqDirEditFieldLabel
            app.SeqDirEditFieldLabel = uilabel(app.UIFigure);
            app.SeqDirEditFieldLabel.HorizontalAlignment = 'right';
            app.SeqDirEditFieldLabel.Position = [50 262 45 22];
            app.SeqDirEditFieldLabel.Text = 'Seq Dir';

            % Create SeqDirEditField
            app.SeqDirEditField = uieditfield(app.UIFigure, 'text');
            app.SeqDirEditField.ValueChangedFcn = createCallbackFcn(app, @SeqDirEditFieldValueChanged, true);
            app.SeqDirEditField.Position = [110 262 309 22];

            % Create ChooseButton
            app.ChooseButton = uibutton(app.UIFigure, 'push');
            app.ChooseButton.ButtonPushedFcn = createCallbackFcn(app, @ChooseButtonPushed, true);
            app.ChooseButton.Position = [437 262 100 22];
            app.ChooseButton.Text = 'Choose';

            % Create Task_size_text
            app.Task_size_text = uilabel(app.UIFigure);
            app.Task_size_text.VerticalAlignment = 'top';
            app.Task_size_text.FontSize = 60;
            app.Task_size_text.FontWeight = 'bold';
            app.Task_size_text.Position = [9 40 308 175];
            app.Task_size_text.Text = 'Test';

            % Create intro_size_text
            app.intro_size_text = uilabel(app.UIFigure);
            app.intro_size_text.VerticalAlignment = 'top';
            app.intro_size_text.FontSize = 25;
            app.intro_size_text.FontWeight = 'bold';
            app.intro_size_text.Position = [324 40 317 175];
            app.intro_size_text.Text = 'Test';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = WM_v5(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end