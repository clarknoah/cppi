classdef Cppi_Manipulator
    %C Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        config
        payload
    end
    
    methods
        function obj=Cppi_Manipulator(config,payload)
            obj.config = config;
            obj.payload = payload;
        end
        function parsed=parse_session_path(obj,path,subject,session)
            parsed = sprintf(path,obj.config.paths.subjects_root,subject,session);
        end
        function file=load_session_file(obj,file_path,subject,session)
            full_path = obj.parse_session_path(file_path,subject,session);
            file = load_untouch_nii(full_path);
        end
        function file_root=save_session_file(obj,file_root,path,subject,session)
            file_root.current_path = path;
            path = obj.parse_session_path(file_root.current_path,subject,session);
            save_untouch_nii(file_root.obj,path);
            
        end
        function xyz = get_mask_xyz(obj,file)
            [x,y,z] = ind2sub(size(file.img), find(file.img(:)));
            xyz = [x(:)';y(:)';z(:)'];
            xyz= xyz';
        end
        function display_overlap(obj,xyz1,xyz2)
            figure;
            subplot(1,3,1)
            scatter3(xyz1(:,1),xyz1(:,2),xyz1(:,3),'red','filled');

            subplot(1,3,2)
            scatter3(xyz2(:,1),xyz2(:,2),xyz2(:,3),'blue','filled');
            
            subplot(1,3,3)
            scatter3(xyz1(:,1),xyz1(:,2),xyz1(:,3),'red','filled');
            hold;
            scatter3(xyz2(:,1),xyz2(:,2),xyz2(:,3),'blue','filled');
            
        end
        function display_scatter(obj,xyz1)
            scatter3(xyz1(:,1),xyz1(:,2),xyz1(:,3),'red','filled')
        end
        function payload=save_json(obj,path,name)
            payload = obj.payload;
            fields=fieldnames(obj.payload.files);
            for x=1:length(fields)
                if(obj.payload.files.(char(fields(x))).hemi==false)
                    payload.files.(char(fields(x))).obj = [];
                elseif(obj.payload.files.(char(fields(x))).hemi==true)
                    payload.files.(char(fields(x))).lh.obj = [];
                    payload.files.(char(fields(x))).rh.obj = [];
                end
            end
            savejson('',payload,[path '/' name]);
        end
        function rois=extract_rois(obj,subject,session)
            rois = [];
             fields=fieldnames(obj.payload.files);
            for x=1:length(fields)
                file = obj.payload.files.(char(fields(x)));
                if(obj.payload.files.(char(fields(x))).hemi==true&& ...
                       strcmp(obj.payload.files.(char(fields(x))).function,'roi'))
                   roi_lh = file.lh;
                   roi_lh.path = obj.parse_session_path(roi_lh.current_path,subject,session);
                   roi_rh = file.rh;
                   roi_rh.path = obj.parse_session_path(roi_rh.current_path,subject,session);

                   rois = [rois,roi_lh,roi_rh];
                end
            end
        end
        %function matching_terms = query_files(obj,query)
        %    fields = fieldnames(obj.payload);
        %    for x=1:length(fields)
        %       
        %    end
        %end
    end
    
end

