classdef app1_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        linestyleListBox       matlab.ui.control.ListBox
        linestyleListBoxLabel  matlab.ui.control.Label
        importfromexelButton   matlab.ui.control.Button
        markerListBox          matlab.ui.control.ListBox
        markerListBoxLabel     matlab.ui.control.Label
        zLabel                 matlab.ui.control.Label
        zEditField             matlab.ui.control.EditField
        typeListBox            matlab.ui.control.ListBox
        typeLabel              matlab.ui.control.Label
        colorListBox           matlab.ui.control.ListBox
        colorLabel             matlab.ui.control.Label
        xEditField             matlab.ui.control.EditField
        yLabel                 matlab.ui.control.Label
        xLabel                 matlab.ui.control.Label
        showplotButton         matlab.ui.control.Button
        yEditField             matlab.ui.control.EditField
        adddatatotableButton   matlab.ui.control.Button
        UITable                matlab.ui.control.Table
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: adddatatotableButton
        function adddatatotableButtonPushed(app, event)
            %disp(app.xEditField.Value);
            tableObj=app.UITable;
            x=str2num(app.xEditField.Value);
            y=str2num(app.yEditField.Value);
            z=str2num(app.zEditField.Value);
            
            value = app.typeListBox.Value;
            vallst=regexp(value,' ','split');
            cells=vallst(:,1)+"";
            old=get(tableObj,'Data');
            if cells == "1"
                new=x;
                if size(old) ~= 0
                    old = old(:,1);
                end
            elseif cells == "2"
                new=[x y];
               if size(old) ~= 0
                   old = old(:,[1,2]);
               end
            else
                new=[x y z];
                if size(old) ~= 0
                    old = old(:,[1,2,3]);
                end
            end
            
            mergeOldNew=[old; new];
            set(tableObj, 'Data',mergeOldNew);

        end

        % Callback function
        function datatypeListBoxValueChanged(app, event)
            value = app.datatypeListBox.Value;
%             if value=="exel"
%                 app.addadressofexelfileEditField.Visible="on";
%                 app.addadressofexelfileEditField.Enable="on";
%                 app.yEditField.Visible="off";
%                 app.yEditField.Enable="off";
%                 app.zEditField.Visible="off";
%                 app.zEditField.Enable="off";
%                 app.xEditField.Visible="off";
%                 app.xEditField.Enable="off";
%                 app.xLabel.Visible="off";
%                 app.zLabel.Visible="off";
%                 app.yLabel.Visible="off";
%                 app.inputexeladdressLabel.Visible="on";
%             elseif value=="manual"
%                 app.addadressofexelfileEditField.Visible="off";
%                 app.addadressofexelfileEditField.Enable="off";
%                 app.yEditField.Visible="on";
%                 app.yEditField.Enable="on";
%                 app.zEditField.Visible="on";
%                 app.zEditField.Enable="on";
%                 app.xEditField.Visible="on";
%                 app.xEditField.Enable="on";
%                 app.xLabel.Visible="on";
%                 app.zLabel.Visible="on";
%                 app.yLabel.Visible="on";
%                 app.inputexeladdressLabel.Visible="off";
%                 
%             end

        end

        % Callback function
        function xEditFieldValueChanged(app, event)
            value = app.xEditField.Value;
            
        end

        % Button pushed function: showplotButton
        function showplotButtonPushed(app, event)
            data = get(app.UITable, 'Data');
%             data=[1 2;3 4;5 6;7 8;9 10];
            value = app.typeListBox.Value;
            vallst=regexp(value,' ','split');
            cells=vallst(:,1)+"";
            type=vallst(:,2)+"";
            if cells == "1"
                if type == "pie"
                    pie(data(:,1));
                end
            elseif cells == "2"
                 if type == "plot"
                    plot(data(:,1),data(:,2),app.colorListBox.Value, Marker=app.markerListBox.Value, MarkerFaceColor=app.colorListBox.Value, LineStyle=app.linestyleListBox.Value);
                 elseif type == "log"
                    loglog(data(:,1),data(:,2),app.colorListBox.Value, Marker=app.markerListBox.Value, MarkerFaceColor=app.colorListBox.Value, LineStyle=app.linestyleListBox.Value);
                 elseif type == "area"
                    area(data(:,1),data(:,2));
                    app.colorListBox.Visible = "off";
                 elseif type == "bar"
                    bar(data(:,1),data(:,2),app.colorListBox.Value);
                 elseif type == "scatter"
                    scatter(data(:,1),data(:,2),app.colorListBox.Value, Marker=app.markerListBox.Value, MarkerFaceColor=app.colorListBox.Value);
                 end
            else
                 if type == "plot3"
                    plot3(data(:,1),data(:,2),data(:,3),app.colorListBox.Value, Marker=app.markerListBox.Value, MarkerFaceColor=app.colorListBox.Value, LineStyle=app.linestyleListBox.Value);
                 elseif type == "scatter3"
                    scatter3(data(:,1),data(:,2),data(:,3),app.colorListBox.Value, Marker=app.markerListBox.Value, MarkerFaceColor=app.colorListBox.Value);
                 end
            end
        end

        % Value changed function: typeListBox
        function typeListBoxValueChanged(app, event)
            value = app.typeListBox.Value;
            tableObj=app.UITable;
            set(tableObj, 'Data',[]);
            vallst=regexp(value,' ','split');
            disp(vallst(:,1)+"");
            cells=vallst(:,1)+"";
            type=vallst(:,2)+"";
            marker=vallst(:,3)+"";
            if cells == "1"
                app.xEditField.Visible="on";
                app.xEditField.Enable="on";
                app.xLabel.Visible="on";
                app.yEditField.Visible="off";
                app.yEditField.Enable="off";
                app.yLabel.Visible="off";
                app.zEditField.Visible="off";
                app.zEditField.Enable="off";
                app.zLabel.Visible="off";
            elseif cells=="2"
                app.xEditField.Visible="on";
                app.xEditField.Enable="on";
                app.xLabel.Visible="on";
                app.yEditField.Visible="on";
                app.yEditField.Enable="on";
                app.yLabel.Visible="on";
                app.zEditField.Visible="off";
                app.zEditField.Enable="off";
                app.zLabel.Visible="off";
            else
                app.xEditField.Visible="on";
                app.xEditField.Enable="on";
                app.xLabel.Visible="on";
                app.yEditField.Visible="on";
                app.yEditField.Enable="on";
                app.yLabel.Visible="on";
                app.zEditField.Visible="on";
                app.zEditField.Enable="on";
                app.zLabel.Visible="on";
            end

            if type ~= "pie" && type ~= "area"
                app.colorListBox.Visible = "on";
                app.linestyleListBox.Visible = "on";
            else
                app.colorListBox.Visible = "off";
                app.linestyleListBox.Visible = "off";
            end

            if marker == "1"
                app.markerListBox.Visible="on";
            else
                app.markerListBox.Visible="off";
            end
        end

        % Value changed function: xEditField
        function xEditFieldValueChanged2(app, event)
            value = app.xEditField.Value;
            
        end

        % Value changing function: xEditField
        function xEditFieldValueChanging(app, event)
            changingValue = event.Value;
            
        end

        % Button pushed function: importfromexelButton
        function importfromexelButtonPushed(app, event)
            [file,path] = uigetfile('*.*');
            data = xlsread(fullfile(path,file));
            tableObj=app.UITable;
            for row = 1:size(data,1)
                old=get(tableObj,'Data');
                new=data(row,:);
                mergeOldNew=[old; new];
%                 disp(data(row,:))
                set(app.UITable, 'Data',mergeOldNew);
            end
        end

        % Cell selection callback: UITable
        function UITableCellSelection(app, event)
            index = event.Indices;

        end

        % Key press function: UITable
        function UITableKeyPress(app, event)
            key = event.Key;
            if key=="delete"
                tableObj=app.UITable;
                index=app.UITable.Selection;
                D=tableObj.Data;
                D(index(1), :) = [];
                tableObj.Data = D;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [1 1 1];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create UITable
            app.UITable = uitable(app.UIFigure);
            app.UITable.ColumnName = {'x'; 'y'; 'z'};
            app.UITable.ColumnRearrangeable = 'on';
            app.UITable.RowName = {};
            app.UITable.ColumnEditable = true;
            app.UITable.CellSelectionCallback = createCallbackFcn(app, @UITableCellSelection, true);
            app.UITable.KeyPressFcn = createCallbackFcn(app, @UITableKeyPress, true);
            app.UITable.Position = [22 43 598 185];

            % Create adddatatotableButton
            app.adddatatotableButton = uibutton(app.UIFigure, 'push');
            app.adddatatotableButton.ButtonPushedFcn = createCallbackFcn(app, @adddatatotableButtonPushed, true);
            app.adddatatotableButton.Position = [317 296 183 23];
            app.adddatatotableButton.Text = 'add data to table ';

            % Create yEditField
            app.yEditField = uieditfield(app.UIFigure, 'text');
            app.yEditField.Enable = 'off';
            app.yEditField.Visible = 'off';
            app.yEditField.Position = [131 296 86 22];

            % Create showplotButton
            app.showplotButton = uibutton(app.UIFigure, 'push');
            app.showplotButton.ButtonPushedFcn = createCallbackFcn(app, @showplotButtonPushed, true);
            app.showplotButton.Position = [521 12 100 23];
            app.showplotButton.Text = 'show plot';

            % Create xLabel
            app.xLabel = uilabel(app.UIFigure);
            app.xLabel.FontSize = 14;
            app.xLabel.Position = [34 317 25 22];
            app.xLabel.Text = 'x:';

            % Create yLabel
            app.yLabel = uilabel(app.UIFigure);
            app.yLabel.FontSize = 14;
            app.yLabel.Visible = 'off';
            app.yLabel.Position = [131 317 25 22];
            app.yLabel.Text = 'y:';

            % Create xEditField
            app.xEditField = uieditfield(app.UIFigure, 'text');
            app.xEditField.ValueChangedFcn = createCallbackFcn(app, @xEditFieldValueChanged2, true);
            app.xEditField.ValueChangingFcn = createCallbackFcn(app, @xEditFieldValueChanging, true);
            app.xEditField.Position = [34 296 76 22];

            % Create colorLabel
            app.colorLabel = uilabel(app.UIFigure);
            app.colorLabel.HorizontalAlignment = 'right';
            app.colorLabel.FontSize = 14;
            app.colorLabel.Position = [140 423 39 22];
            app.colorLabel.Text = 'color:';

            % Create colorListBox
            app.colorListBox = uilistbox(app.UIFigure);
            app.colorListBox.Items = {'red', 'blue', 'black', 'green', 'purple', 'yellow'};
            app.colorListBox.Position = [142 374 92 50];
            app.colorListBox.Value = 'red';

            % Create typeLabel
            app.typeLabel = uilabel(app.UIFigure);
            app.typeLabel.FontSize = 14;
            app.typeLabel.Position = [34 423 51 22];
            app.typeLabel.Text = 'type:';

            % Create typeListBox
            app.typeListBox = uilistbox(app.UIFigure);
            app.typeListBox.Items = {'pie', 'plot', 'log', 'area', 'bar', 'scatter', 'plot3', 'scatter3'};
            app.typeListBox.ItemsData = {'1 pie 0', '2 plot 1', '2 log 1', '2 area 1', '2 bar 0', '2 scatter 1', '3 plot3 1', '3 scatter3 1'};
            app.typeListBox.ValueChangedFcn = createCallbackFcn(app, @typeListBoxValueChanged, true);
            app.typeListBox.Position = [32 374 100 50];
            app.typeListBox.Value = '1 pie 0';

            % Create zEditField
            app.zEditField = uieditfield(app.UIFigure, 'text');
            app.zEditField.Enable = 'off';
            app.zEditField.Visible = 'off';
            app.zEditField.Position = [230 296 81 22];

            % Create zLabel
            app.zLabel = uilabel(app.UIFigure);
            app.zLabel.FontSize = 14;
            app.zLabel.Visible = 'off';
            app.zLabel.Position = [230 317 25 22];
            app.zLabel.Text = 'z:';

            % Create markerListBoxLabel
            app.markerListBoxLabel = uilabel(app.UIFigure);
            app.markerListBoxLabel.FontSize = 14;
            app.markerListBoxLabel.Position = [392 423 53 22];
            app.markerListBoxLabel.Text = 'marker:';

            % Create markerListBox
            app.markerListBox = uilistbox(app.UIFigure);
            app.markerListBox.Items = {'circle', 'Asterisk', 'Point', 'Plus sign	', 'Cross', 'Horizontal line	', 'Vertical line	', 'Square', 'Diamond'};
            app.markerListBox.ItemsData = {'o', '*', '.', '+', '-', 'x', '_', '|', 'square', 'diamond'};
            app.markerListBox.Position = [386 374 136 50];
            app.markerListBox.Value = 'o';

            % Create importfromexelButton
            app.importfromexelButton = uibutton(app.UIFigure, 'push');
            app.importfromexelButton.ButtonPushedFcn = createCallbackFcn(app, @importfromexelButtonPushed, true);
            app.importfromexelButton.Position = [22 238 102 23];
            app.importfromexelButton.Text = 'import from exel';

            % Create linestyleListBoxLabel
            app.linestyleListBoxLabel = uilabel(app.UIFigure);
            app.linestyleListBoxLabel.HorizontalAlignment = 'right';
            app.linestyleListBoxLabel.FontSize = 14;
            app.linestyleListBoxLabel.Position = [245 423 63 22];
            app.linestyleListBoxLabel.Text = 'line style:';

            % Create linestyleListBox
            app.linestyleListBox = uilistbox(app.UIFigure);
            app.linestyleListBox.Items = {'-', '--', ':', '-.'};
            app.linestyleListBox.Position = [245 374 131 50];
            app.linestyleListBox.Value = '-';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

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